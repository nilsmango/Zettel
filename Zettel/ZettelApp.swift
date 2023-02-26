//
//  ZettelApp.swift
//  Zettel
//
//  Created by Simon Lang on 07.11.21.
//

import SwiftUI
import WidgetKit

@main
struct ZettelApp: App {
    init() {
        UITextView.appearance().backgroundColor = UIColor(Color("WidgetColor"))
    }
    
    @StateObject private var zettelData = ZettelData()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var watchConnection = WatchConnection()

    private func updateZettel() {
        print("Trying to send list to watch")
        if watchConnection.session.activationState == .activated {
            
            var zettelDictionary: [String : Any] = [:]
                
            let newZettel = zettelData.zettel.first?.text
            
            zettelDictionary["zettelPost"] = newZettel
            
            watchConnection.session.transferUserInfo(zettelDictionary)

        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView(zettelData: zettelData)
                .onAppear() {
                    zettelData.load()
                    zettelData.deletedZettel.removeAll()
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        updateZettel()
                        zettelData.save()
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                }
        }
    }
}
