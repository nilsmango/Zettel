//
//  WidgetPreview.swift
//  Zettel
//
//  Created by Simon Lang on 07.09.2024.
//

import SwiftUI
import WidgetKit

//struct WidgetPreview<Content: View>: View {
//    let content: Content
//    let family: WidgetFamily
//    
//    init(family: WidgetFamily, @ViewBuilder content: () -> Content) {
//        self.family = family
//        self.content = content()
//    }
//    
//    var body: some View {
//        content
//            .frame(width: widgetSize.width, height: widgetSize.height)
//            .background(Color(UIColor.systemBackground))
//            .cornerRadius(21.67)
//            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
//    }
//    
//    
//    
//    private var widgetSmallSize: CGSize {
//        WidgetFamily.systemSmall.contentSize
//    }
//    
//    private var widgetSize: CGSize {
//        WidgetConfiguration.supportedFamilies()
//        WidgetFamily.supportedFamilies.first { $0 == family }?.contentSize ?? .zero
//    }
//}
