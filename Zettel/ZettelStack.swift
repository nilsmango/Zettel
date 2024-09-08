//
//  ZettelStack.swift
//  Zettel
//
//  Created by Simon Lang on 08.09.2024.
//

import SwiftUI

struct ZettelStack: View {
    var text: String
    var textSize: CGFloat
    var isWidget: Bool = false
    
    var body: some View {
        
        VStack {
            if isWidget {
                Text(text)
                    .font(.system(size: textSize))
                    .minimumScaleFactor(0.4)
                    .widgetAccentable()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            } else {
                Text(text)
                    .font(.system(size: textSize))
                    .minimumScaleFactor(0.4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            Spacer()
        }
    }
}

#Preview {
    ZettelStack(text: "Let's fucking go.", textSize: 16)
}
