//
//  TimeLabelView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI

struct TimeLabelView: View {
    @State var taskName: String
    @State var colors: Color
    let timeText = 6..<24
    let timeTextWidth: CGFloat = 40
    
    var body: some View {
        ZStack {
            HStack {
                Divider()
            }
            .padding(.leading, timeTextWidth)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 0) {
                NavigationBarView(naviTitle: taskName, enumNavi: .dismiss)
                    .padding(.horizontal, -20)
                
                ForEach(timeText, id: \.self) { i in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("\(i)")
                                .foregroundColor(.black)
                                .padding(.horizontal, 5)
                                .frame(width: timeTextWidth)
                            
                            ButtonView(colors: colors)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }
}

struct ButtonView: View {
    @State var colors: Color
    @State private var boolArray = [false, false, false, false, false]
    @State private var draggedColumnIndex: Int?
    let timeCheckButtonCount = 0..<5
    
    var body: some View {
        ForEach(timeCheckButtonCount, id: \.self) { index in
            Button {
                boolArray[index] = true
            } label: {
                RoundedRectangle(cornerRadius: 0)
                    .fill(boolArray[index] ? colors : Color.gray.opacity(0.1))
            }
            .frame(width: 60)
            .padding(.vertical, 4)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let dragPosition = value.location
                        let dragPositionInt = Int(dragPosition.x)
                        let columnIndex = dragPositionInt / 60
                        if columnIndex != draggedColumnIndex && columnIndex < boolArray.count {
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
        TimeLabelView(taskName: "TEST", colors: .white)
    }
}
