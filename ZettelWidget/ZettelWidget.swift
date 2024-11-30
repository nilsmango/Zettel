//
//  ZettelWidget.swift
//  ZettelWidget
//
//  Created by Simon Lang on 11.11.21.
//

import WidgetKit
import SwiftUI
import CryptoKit
import Security

struct Provider: TimelineProvider {
    private let keychainService = "group.zettel"
    private let keychainAccount = "EncryptionKey"
    private let keychainAccessGroup = "group.zettel"
    
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
    
    // Decrypt data
    private func decrypt(_ encryptedData: Data) throws -> Data {
        let key = try getOrCreateEncryptionKey()
        let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
        return try AES.GCM.open(sealedBox, using: key)
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
    
    // Load and decrypt notes from file
    func load(completion: @escaping ([Zettel]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                // Read encrypted data from file
                let fileURL = self.getDocumentsDirectory().appendingPathComponent("encrypted_zettel.data")
                let encryptedData = try Data(contentsOf: fileURL)
                
                // Decrypt data
                let decryptedData = try self.decrypt(encryptedData)
                
                // Decode JSON
                let decryptedZettel = try JSONDecoder().decode([Zettel].self, from: decryptedData)
                
                DispatchQueue.main.async {
                    completion(decryptedZettel)
                }
            } catch {
                print("Error loading encrypted notes: \(error)")
                DispatchQueue.main.async {
                    completion([Zettel(text: "Your notes on the Zettel", showSize: .small, fontSize: .normal)])
                }
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
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), zettel: [Zettel(text: "Your notes on the Zettel. In a Zettel widget, on your Home Screen, for you to check and edit!", showSize: .small, fontSize: .compact)])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), zettel: [Zettel(text: "Your notes on the Zettel. In a Zettel widget, on your Home Screen, for you to check and edit!", showSize: .small, fontSize: .compact)])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print("going to load zettel")
        load() { zettel in
            print("loaded zettel")
            let entries = [SimpleEntry(date: Date(), zettel: zettel)]
            
            let timeline = Timeline(entries: entries, policy: .never)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let zettel: [Zettel]
}

struct ZettelWidgetEntryView : View {
    @Environment(\.widgetRenderingMode) var renderingMode
    var entry: Provider.Entry
    
    private var textSize: CGFloat {
            return makeTextSize(for: entry.zettel.first?.fontSize ?? .huge)
        }
        
    var body: some View {
        ZStack {
            switch renderingMode {
            case .accented:
                ZettelStack(text: entry.zettel[0].text, textSize: textSize, isWidget: true)
                    .containerBackground(for: .widget) {
                                    Color("WidgetColor")
                                }
                    
            default:
                ZettelStack(text: entry.zettel[0].text, textSize: textSize, isWidget: true)
                    .containerBackground(for: .widget) {
                                    Color("WidgetColor")
                                }
            }
        }
    }
}

@main
struct ZettelWidget: Widget {
    let kind: String = "ZettelWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ZettelWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Zettel Widget")
        .description("Shows your Zettel notes in a widget.")
    }
}

struct ZettelWidget_Previews: PreviewProvider {
    static var previews: some View {
        ZettelWidgetEntryView(entry: SimpleEntry(date: Date(), zettel: [Zettel(text: "Your notes on the Zettel", showSize: .small, fontSize: .normal)]))
//            .preferredColorScheme(.dark)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
