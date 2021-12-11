//
//  MainView.swift
//  Zettel
//
//  Created by Simon Lang on 11.12.21.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var zettelData: ZettelData
    
    @State private var historyShowing = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
        if historyShowing {
            ZettelHistory(zettelData: zettelData, isPresented: $historyShowing)
                .transition(.move(edge: .bottom))
        } else {
            ContentView(zettelData: zettelData, isPresented: $historyShowing.animation())
        }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(zettelData: ZettelData())
    }
}
