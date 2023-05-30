//
//  EnumNavi.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/15.
//

import SwiftUI

enum EnumNavi {
    case back
    case save
}


enum EnumColor: String {
    case red = "red"
    case pink = "pink"
    case orange = "orange"
    case yellow = "yellow"
    case green = "green"
    case blue = "blue"
    case purple = "purple"
    case black = "black"
    case gray = "gray"
    case brown = "brown"
    
    static func colorPick(color: String) -> Color {
        switch color {
        case "red":
            return .red.opacity(0.4)
        case "pink":
            return .pink.opacity(0.4)
        case "orange":
            return .orange.opacity(0.4)
        case "yellow":
            return .yellow.opacity(0.4)
        case "green":
            return .green.opacity(0.4)
        case "blue":
            return .blue.opacity(0.4)
        case "purple":
            return .purple.opacity(0.4)
        case "black":
            return .black.opacity(0.4)
        case "gray":
            return .gray.opacity(0.4)
        case "brown":
            return .brown.opacity(0.4)
        default:
            return .white
        }
    }
}
