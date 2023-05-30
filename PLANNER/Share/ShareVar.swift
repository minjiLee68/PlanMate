//
//  ShareVar.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/23.
//

import SwiftUI

struct ShareVar {
    static func color(color: String) -> Color {
        return EnumColor.colorPick(color: color)
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
}
