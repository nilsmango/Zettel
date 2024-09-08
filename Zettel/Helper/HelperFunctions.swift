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

func makeTextSize(for fontSize: Zettel.FontSize) -> CGFloat {
    if fontSize == .large {
        return CGFloat(20)
    } else if fontSize == .compact {
        return CGFloat(12)
    } else if fontSize == .huge {
        return CGFloat(32)
    } else {
        return CGFloat(16)
    }
}

/// Initial About Text and Version Log / Change Log
let initAboutText = "About\nproject7III makes useful things.\nFind us: project7iii.com\nWrite to us: hi@project7iii.com\n\nHow to add a Zettel widget\n1. Go to the Home Screen\n2. Long press to enter wiggle mode\n3. Tap the +\n4. Search for Zettel\n5. Add the Zettel widget of your choice\n\nNote: The widget will always show the Zettel you worked on last.\n\nChangelog:\n1.0 fixed and finished the app, 2024.\n0.1 made with ❤️ by Nils Mango (nilsmango.ch) in Switzerland, 2021-2022."

func geoMagic(width: CGFloat, height: CGFloat, showingSheet: Bool, widgetSize: Zettel.ShowSize) -> (width: CGFloat, height: CGFloat) {
    if showingSheet {
        // Large widget dimensions when showing sheet
        switch (width, height) {
        case (428...430, 926...932): return (364, 382)
        case (414, 896): return (360, 379)
        case (414, 736): return (348, 357)
        case (390...393, 844...852): return (338, 354)
        case (375, 812), (360, 780): return (329, 345)
        case (375, 667): return (321, 324)
        case (320, 568): return (292, 311)
        case (768, _): return (260, 260)
        case (810, _): return (272, 272)
        case (820, _), (834, 1194): return (300, 300)
        case (834, 1112): return (288, 288)
        case (1024, _): return (356, 356)
        case (954...970, 1373...1389): return (350, 350)
        case (1192, 1590): return (412, 412)
        default: return (width/3, height/5)
        }
    } else {
        // Widget dimensions when not showing sheet
        switch (width, height) {
        case (428...430, 926...932):
            switch widgetSize {
            case .small: return (170, 170)
            case .medium: return (364, 170)
            case .large: return (364, 382)
            }
        case (414, 896):
            switch widgetSize {
            case .small: return (169, 169)
            case .medium: return (360, 169)
            case .large: return (360, 379)
            }
        case (414, 736):
            switch widgetSize {
            case .small: return (159, 159)
            case .medium: return (348, 157)
            case .large: return (348, 357)
            }
        case (390...393, 844...852):
            switch widgetSize {
            case .small: return (158, 158)
            case .medium: return (338, 158)
            case .large: return (338, 354)
            }
        case (375, 812), (360, 780):
            switch widgetSize {
            case .small: return (155, 155)
            case .medium: return (329, 155)
            case .large: return (329, 345)
            }
        case (375, 667):
            switch widgetSize {
            case .small: return (148, 148)
            case .medium: return (321, 148)
            case .large: return (321, 324)
            }
        case (320, 568):
            switch widgetSize {
            case .small: return (141, 141)
            case .medium: return (292, 141)
            case .large: return (292, 311)
            }
        case (768, _):
            switch widgetSize {
            case .small: return (120, 120)
            case .medium: return (260, 120)
            case .large: return (260, 260)
            }
        case (810, _):
            switch widgetSize {
            case .small: return (124, 124)
            case .medium: return (272, 124)
            case .large: return (272, 272)
            }
        case (820, _), (834, 1194):
            switch widgetSize {
            case .small: return (136, 136)
            case .medium: return (300, 136)
            case .large: return (300, 300)
            }
        case (834, 1112):
            switch widgetSize {
            case .small: return (132, 132)
            case .medium: return (288, 132)
            case .large: return (288, 288)
            }
        case (1024, _):
            switch widgetSize {
            case .small: return (160, 160)
            case .medium: return (356, 160)
            case .large: return (356, 356)
            }
        case (954...970, 1373...1389):
            switch widgetSize {
            case .small: return (162, 162)
            case .medium: return (350, 162)
            case .large: return (350, 350)
            }
        case (1192, 1590):
            switch widgetSize {
            case .small: return (188, 188)
            case .medium: return (412, 188)
            case .large: return (412, 412)
            }
        default:
            return (width/3, height/5)
        }
    }
}
