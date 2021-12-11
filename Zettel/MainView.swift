//
//  MainView.swift
//  Zettel
//
//  Created by Simon Lang on 11.12.21.
//

import SwiftUI

struct MainView: View {
    
    @State private var historyShowing = false
    
    var body: some View {
        if historyShowing {
            ZettelHistory(zettelData: <#T##ZettelData#>, isPresented: $historyShowing)
        }
        ContentView()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
