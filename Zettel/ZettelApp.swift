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
    
    var body: some Scene {
        WindowGroup {
            MainView(zettelData: zettelData)
                .onAppear() {
                    zettelData.load()
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        zettelData.save()
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                }
        }
    }
}
