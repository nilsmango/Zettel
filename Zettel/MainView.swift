//
//  MainView.swift
//  Zettel
//
//  Created by Simon Lang on 11.12.21.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    @StateObject private var zettelData = ZettelData()
 
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var historyShowing = false
    
    var body: some View {
        
        if historyShowing {
            ZettelHistory(zettelData: zettelData, isPresented: $historyShowing)
        } else {
            ContentView(zettelData: zettelData, isPresented: $historyShowing)
                .onAppear() {
                    zettelData.load()
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive { zettelData.save() }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
