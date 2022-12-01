//
//  ContentView.swift
//  ZettelWatch Watch App
//
//  Created by Simon Lang on 01.12.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            ZStack {
                Color("WidgetColor")
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: true) {
                    Text("Hello, world!\nThis is a sample text, to see how a note would look on apple watch.\nAnother line another day.\nNow what?\nWho that? Man it's a fucking\nFuck that he said and stormed out of the motherfucking house. It was a great day for")
                        .multilineTextAlignment(.leading)
                        .padding(EdgeInsets(top: 7, leading: 12, bottom: 7, trailing: 12))
                }
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
