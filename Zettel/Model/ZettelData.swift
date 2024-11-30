//
//  ZettelData.swift
//  Zettel
//
//  Created by Simon Lang on 09.11.21.
//

import Foundation
import WidgetKit
import SwiftUI
import CryptoKit
import Security

class ZettelData: ObservableObject {
    @Published var zettel: [Zettel] = [Zettel(text: "This is your note.", showSize: .small, fontSize: .compact)]
    @Published var deletedZettel: [Zettel] = []
    
    private let keychainService = "group.zettel"
    private let keychainAccount = "EncryptionKey"
    private let keychainAccessGroup = "group.zettel"
    
    func restoreLastDeletedZettel() {
        let restoredZettel = deletedZettel.last ?? Zettel(text: "We couldn't find your last note.", showSize: .small, fontSize: .compact)
        deletedZettel.removeLast()
        zettel.append(restoredZettel)
    }
    
    private func saveKeyToKeychain(_ keyData: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: keychainAccount,
            kSecAttrAccessGroup as String: keychainAccessGroup, // Use your App Group identifier
            kSecValueData as String: keyData
        ]
        
        // Delete any existing key
        SecItemDelete(query as CFDictionary)
        
        // Add new key
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw NSError(domain: "KeychainError", code: Int(status), userInfo: nil)
        }
    }

    private func getOrCreateEncryptionKey() throws -> SymmetricKey {
        // Try to retrieve existing key from Keychain
        if let existingKeyData = retrieveKeyFromKeychain() {
            return SymmetricKey(data: existingKeyData)
        }
        
        // Generate a new key if not found
        let newKey = SymmetricKey(size: .bits256)
        try saveKeyToKeychain(newKey.withUnsafeBytes { Data(Array($0)) })
        return newKey
    }
    
    // Retrieve key from Keychain
    private func retrieveKeyFromKeychain() -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: keychainAccount,
            kSecAttrAccessGroup as String: keychainAccessGroup, // Use your App Group identifier
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        return status == errSecSuccess ? result as? Data : nil
    }
    
    // Encrypt data
    private func encrypt(_ data: Data) throws -> Data {
        let key = try getOrCreateEncryptionKey()
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }
    
    // Decrypt data
    private func decrypt(_ encryptedData: Data) throws -> Data {
        let key = try getOrCreateEncryptionKey()
        let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
        return try AES.GCM.open(sealedBox, using: key)
    }
    
    // Save encrypted notes to file
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            do {
                // Encode notes to JSON
                let jsonData = try JSONEncoder().encode(self.zettel)
                
                // Encrypt JSON data
                let encryptedData = try self.encrypt(jsonData)
                
                // Write encrypted data to file
                let fileURL = self.getDocumentsDirectory().appendingPathComponent("encrypted_zettel.data")
                try encryptedData.write(to: fileURL)
                
                DispatchQueue.main.async {
                    WidgetCenter.shared.reloadAllTimelines()
                }
            } catch {
                print("Error saving encrypted notes: \(error)")
            }
        }
    }
    
    // Load and decrypt notes from file
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            do {
                // Read encrypted data from file
                let fileURL = self.getDocumentsDirectory().appendingPathComponent("encrypted_zettel.data")
                let encryptedData = try Data(contentsOf: fileURL)
                
                // Decrypt data
                let decryptedData = try self.decrypt(encryptedData)
                
                // Decode JSON
                let decryptedZettel = try JSONDecoder().decode([Zettel].self, from: decryptedData)
                
                DispatchQueue.main.async {
                    self.zettel = decryptedZettel
                }
            } catch {
                print("Error loading encrypted notes: \(error)")
            }
        }
    }
    
    // Helper method to get documents directory
    private func getDocumentsDirectory() -> URL {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: keychainService) else {
            fatalError("Shared container could not be accessed.")
        }
        return containerURL
    }
}
