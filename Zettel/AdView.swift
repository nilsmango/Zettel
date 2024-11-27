//
//  AdView.swift
//  Zettel
//
//  Created by Simon Lang on 13.09.2024.
//

import SwiftUI

/// Uses images 200 x 200 px
struct AdView: View {
    var body: some View {
        // TODO: take notice from 7III meditation
        let currentAd = zettelAds.randomElement()!
        
        Link(destination: currentAd.url, label: {
            HStack {
                currentAd.image
                
                    Text(currentAd.title)
                        
            }
        })
        
        Link(destination: currentAd.url, label: {
            HStack {
                currentAd.image
                Text(currentAd.subTitle)
                
            }
        })
        
        
        
    }
}

#Preview {
    AdView()
        .frame(width: 300)
}
