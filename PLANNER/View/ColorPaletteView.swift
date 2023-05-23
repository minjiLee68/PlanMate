//
//  ColorPalette.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/23.
//

import SwiftUI

struct ColorPaletteView: View {
    private let colors: [[String]] = [
        [EnumColor.red.rawValue,
         EnumColor.pink.rawValue,
         EnumColor.orange.rawValue,
         EnumColor.yellow.rawValue,
         EnumColor.green.rawValue],
        [EnumColor.blue.rawValue,
         EnumColor.purple.rawValue,
         EnumColor.black.rawValue,
         EnumColor.gray.rawValue,
         EnumColor.brown.rawValue]
    ]
    
    @Binding var pickColor: String
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
                .ignoresSafeArea()
            
            VStack {
                ForEach(colors, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { color in
                            Button {
                                pickColor = color
                            } label: {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(EnumColor.colorPick(color: color))
                            }
                        }
                    }
                }
            }
            .frame(
                width: 280,
                height: 150
            )
            .background(Color.white)
            .cornerRadius(15)
        }
    }
}

struct ColorPaletteView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPaletteView(pickColor: .constant("red"))
    }
}
