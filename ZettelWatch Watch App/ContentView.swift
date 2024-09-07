//
//  ContentView.swift
//  ZettelWatch Watch App
//
//  Created by Simon Lang on 01.12.22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var phoneConnection = PhoneConnection()
    
    var body: some View {
        if phoneConnection.zettelText != "" {
            ScrollView(showsIndicators: true) {
                Text(phoneConnection.zettelText)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 7, leading: 12, bottom: 7, trailing: 12))
            }
        } else {
            Text("No text from iPhone yet.")
                .padding(EdgeInsets(top: 7, leading: 12, bottom: 7, trailing: 12))
        }
    }
}


#Preview {
    ContentView()
}
