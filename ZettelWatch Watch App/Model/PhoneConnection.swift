//
//  PhoneConnection.swift
//  ZettelWatch WatchKit Extension
//
//  Created by Simon Lang on 01.12.22.
//

import Foundation
import WatchConnectivity


class PhoneConnection: NSObject, WCSessionDelegate, ObservableObject {
    
    @Published var zettelText: String = ""
    
    let session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("Message from Watch: The session has completed activation.")
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo message: [String : Any]) {
        
        DispatchQueue.main.async {
            print("Mapping in progress")
            self.zettelText = message.values.first as! String
            
            self.save()
            
        }
    }
    
    
    // Load and save the local watch QR codes, works because of the extension. I honestly don't understand how.
    
    let saveKey = "WatchZettel"
    
    func load() {
        let defaults = UserDefaults.standard
        zettelText = try! defaults.decode(String.self, forKey: saveKey) ?? ""
    }
    
    func save() {
        let defaults = UserDefaults.standard
        try? defaults.encode(zettelText, forKey: saveKey)

    }
    
}
