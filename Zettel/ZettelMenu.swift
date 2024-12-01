//
//  ZettelMenu.swift
//  Zettel
//
//  Created by Simon Lang on 01.12.2024.
//

import SwiftUI

struct ZettelMenu: View {
    @Binding var showingSheet: Bool
    @Binding var zettel: Zettel
    var isPad = false
    
    var body: some View {
        Menu {
            Picker("Widget Size Shown", selection: $zettel.showSize) {
                ForEach(Zettel.ShowSize.allCases) { type in
                    Text(type.rawValue.capitalized + " Widget")
                        .tag(type)
                }
            }
            
            
            Picker("Font Size", selection: $zettel.fontSize) {
                ForEach(Zettel.FontSize.allCases) { type in
                    Text(type.rawValue.capitalized + " Font")
                        .tag(type)
                }
            }
            
//                            AdView()
//
//                            Button(action: {
//                                // TODO: Add donation thing
//                            } ) {
//                                Label("Remove Ads & Support Us", systemImage: "heart")
//                            }
            
            Button(action: { showingSheet = true } ) {
                Label("About", systemImage: "info.circle")
            }
            
            
            
            
        } label: {
            Label("Options", systemImage: "ellipsis.circle.fill")
                .labelStyle(.iconOnly)
                .font(isPad ? .title : .title2)
                .contentShape(Rectangle())
        }
    }
}

#Preview {
    ZettelMenu(showingSheet: .constant(false), zettel: .constant(Zettel(text: "Very good", showSize: .medium, fontSize: .compact)))
}
