//
//  HelperFunctions.swift
//  Zettel
//
//  Created by Simon Lang on 11.12.21.
//

import Foundation
import SwiftUI


extension View {
    func withoutAnimation() -> some View {
        self.animation(nil, value: UUID())
    }
}
