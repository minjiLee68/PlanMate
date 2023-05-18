//
//  TimeLabelView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI

struct TimeLabelView: View {
    @State var selectTask = "TASK 0"
    var selectTasks = ["TASK 0", "TASK 1", "TASK 2"]
    
    @State var taskName: String
//    @State var colors: Color
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
                VStack(spacing: 5) {
                    NavigationBarView(naviTitle: selectTask, enumNavi: .dismiss)
                        .padding(.horizontal, -20)
                    
                    Picker("selectTask", selection: $selectTask) {
                            ForEach(selectTasks, id: \.self) {
                              Text($0)
                            }
                          }
                          .pickerStyle(.segmented)
                          .padding(3)
                          .cornerRadius(5)
                          .padding(.vertical, 3)
                }
                .background(Color.white)
                
                ForEach(timeText, id: \.self) { i in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("\(i)")
                                .foregroundColor(.black)
                                .padding(.horizontal, 5)
                                .frame(width: timeTextWidth)
                            
                            ButtonView(selectTask: $selectTask)
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
    @Binding var selectTask: String
    @State private var boolArray = [false, false, false, false, false]
    @State private var buttonColorList = [TestColorModel]()
    @State private var draggedColumnIndex: Int?
    let timeCheckButtonCount = 0..<5
    
    var body: some View {
        ForEach(timeCheckButtonCount, id: \.self) { index in
            Button {
                boolArray[index].toggle() // 버튼 색상을 변경하기 위해 toggle 사용
                testColorData() // 색상 업데이트
            } label: {
                RoundedRectangle(cornerRadius: 0)
                    .fill(boolArray[index] ? colors(forIndex: index) : Color.gray.opacity(0.1))
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
                            boolArray[columnIndex].toggle() // 드래그 동작 시 버튼 색상을 변경
                            testColorData() // 색상 업데이트
                        }
                    }
            )
        }
    }
    
    func testColorData() {
        if selectTask == "TASK 0"{
            buttonColorListAppend(color: .pink.opacity(0.4))
        } else if selectTask == "TASK 1" {
            buttonColorListAppend(color: .green.opacity(0.4))
        } else {
            buttonColorListAppend(color: .yellow.opacity(0.4))
        }
    }
    
    func buttonColorListAppend(color: Color) {
        if buttonColorList.count >= 5 {
            return
        }
        buttonColorList.append(TestColorModel(color: color))
//        if !buttonColorList.contains(where: { $0.color == color }) {
//            buttonColorList.append(TestColorModel(color: color))
//        }
    }
    
    func colors(forIndex index: Int) -> Color {
        if buttonColorList.isEmpty {
            if selectTask == "TASK 0" {
                return .pink.opacity(0.4)
            } else if selectTask == "TASK 1" {
                return .green.opacity(0.4)
            } else {
                return .yellow.opacity(0.4)
            }
        } else {
            return buttonColorList[index].color
        }
    }
}




struct TimeLabelView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLabelView(taskName: "TEST")
    }
}
