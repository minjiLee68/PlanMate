//
//  TimeLabelView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI

struct TimeLabelView: View {
    let timeText = 6..<23
    let timeTextWidth: CGFloat = 40
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(timeText, id: \.self) { i in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("\(i)")
                                .foregroundColor(.black)
                                .padding(.horizontal, 5)
                                .frame(width: timeTextWidth)
                            
                            ButtonView()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                    }
                }
            }
            
            HStack {
                Divider()
            }
            .padding(.leading, timeTextWidth)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
    }
}

struct ButtonView: View {
    @State private var boolArray = [false, false, false, false, false]
    @State private var draggedColumnIndex: Int?
    @State private var color: Color = .clear
    @State private var lastGesture: Int = 0
    let timeCheckButtonCount = 0..<5
    
    var body: some View {
        ForEach(timeCheckButtonCount, id: \.self) { index in
            Button {
//                isClickTest[col].toggle()
            } label: {
                RoundedRectangle(cornerRadius: 0)
                    .fill(boolArray[index] ? Color.green : Color.gray)
            }
            .frame(width: 60)
            .padding(.vertical, 4)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        let dragPosition = value.location
                        let columnIndex = Int(dragPosition.x / 60)
                        if columnIndex != draggedColumnIndex {
                            draggedColumnIndex = columnIndex
                            boolArray[columnIndex] = true
                        }
                    }
            )
        }
    }
}




struct TimeLabelView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLabelView()
    }
}
