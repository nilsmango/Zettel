//
//  ZettelApp.swift
//  Zettel
//
//  Created by Simon Lang on 07.11.21.
//

import SwiftUI

@main
struct ZettelApp: App {
    init() {
        UITextView.appearance().backgroundColor = .clear
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
                    if phase == .inactive { zettelData.save() }
                }
        }
    }
}
