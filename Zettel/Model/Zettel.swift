//
//  Zettel.swift
//  Zettel
//
//  Created by Simon Lang on 09.11.21.
//

import Foundation

struct Zettel: Identifiable, Codable, Hashable {
    
    enum ShowSize: String, Codable, CaseIterable, Identifiable {
        case small, medium, large
        
        var id: String { self.rawValue }
    }
    
    enum FontSize: String, Codable, CaseIterable, Identifiable {
        case compact, normal, large, huge
        
        var id: String { self.rawValue }
    }
    
    var text: String
    var showSize: ShowSize
    var fontSize: FontSize
    let id: String
    
    
    init(text: String, showSize: ShowSize, fontSize: FontSize, id: String = UUID().uuidString) {
        self.text = text
        self.showSize = showSize
        self.fontSize = fontSize
        self.id = id
    }
    
}

extension Zettel {
    static var sampleData: [Zettel] {
        [Zettel(text: "First!", showSize: .small, fontSize: .normal), Zettel(text: "Second!", showSize: .large, fontSize: .normal), Zettel(text: "Third!", showSize: .small, fontSize: .normal), Zettel(text: "Filthy motherfuckers!", showSize: .medium, fontSize: .normal), Zettel(text: "last!", showSize: .small, fontSize: .normal)]
    }
}
