//
//  ReadingTextHeight.swift
//  Zettel
//
//  Created by Simon Lang on 08.09.2024.
//

import SwiftUI

struct ReadingTextHeight: View {
    var text: String

        var body: some View {
            Text(text)
                .background(
                    GeometryReader { geometry in
                        Color.gray
                            .onAppear {
                                print("Text height: \(geometry.size.height)")
                            }
                            .onChange(of: geometry.size.height) { oldHeight, newHeight in
                                print("Text height changed: \(geometry.size.height)")
                            }
                    }
                )
        }
    }

#Preview {
    ReadingTextHeight(text: "text\nnew")
}
