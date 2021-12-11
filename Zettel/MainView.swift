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
        
        if historyShowing {
            ZettelHistory(zettelData: zettelData, isPresented: $historyShowing)
        } else {
            ContentView(zettelData: zettelData, isPresented: $historyShowing)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(zettelData: ZettelData())
    }
}
