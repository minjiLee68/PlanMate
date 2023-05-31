//
//  TimeLabelView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI

struct TimeLabelView: View {
    @State var selectTask: String
    @State var selectTasks: [String]
    @State var colorList: [Color]
    @State var color: Color = .white
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
                VStack(spacing: 0) {
                    NavigationBarView(
                        naviTitle: selectTask,
                        enumNavi: .back)
                    
                    Picker("selectTask", selection: $selectTask) {
                        ForEach(selectTasks, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                    .accentColor(.black.opacity(0.7))
                    .font(.callout)
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .background(Color.white)
                
                ForEach(timeText, id: \.self) { i in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("\(i)")
                                .foregroundColor(.black)
                                .padding(.horizontal, 5)
                                .frame(width: timeTextWidth)
                            
                            ButtonView(selectTask: $selectTask, color: $color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                    }
                }
            }
            .onChange(of: selectTask) { newValue in
                for task in selectTasks.indices {
                    if selectTask == selectTasks[task] {
                        color = colorList[task]
                    }
                }
            }
            .onAppear {
                color = colorList.first ?? .white
            }
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }
}

struct ButtonView: View {
    @Binding var selectTask: String
    @Binding var color: Color
    @State private var boolArray = [false, false, false, false, false]
    @State private var buttonColorList = [TestColorModel]()
    @State private var draggedColumnIndex: Int = 0
    let timeCheckButtonCount = 0..<5
    
    var body: some View {
        ForEach(boolArray.indices, id: \.self) { index in
            Button {
                boolArray[index].toggle() // 버튼 색상을 변경하기 위해 toggle 사용
                testColorData() // 색상 업데이트
            } label: {
                RoundedRectangle(cornerRadius: 0)
                    .fill(boolArray[index] ? colors(forIndex: index) : Color.gray.opacity(0.1))
            }
            .frame(width: 60)
            .padding(.vertical, 4)
//            .simultaneousGesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged { value in
//                        let dragPosition = value.location
//                        let dragPositionInt = Int(dragPosition.x)
//                        let columnIndex = dragPositionInt / 60
//
//                        if columnIndex != draggedColumnIndex && columnIndex < boolArray.count {
//                            draggedColumnIndex = columnIndex
//                            boolArray[columnIndex].toggle() // 드래그 동작 시 버튼 색상을 변경
//                            testColorData() // 색상 업데이트
//                        }
//                    }
//            )
        }
    }
    
    func testColorData() {
        if selectTask == "TASK 0"{
            buttonColorListAppend(color: color)
        } else if selectTask == "TASK 1" {
            buttonColorListAppend(color: color)
        } else {
            buttonColorListAppend(color: color)
        }
    }
    
    func buttonColorListAppend(color: Color) {
        if buttonColorList.count >= 5 {
            return
        }
        buttonColorList.append(TestColorModel(color: color))
    }
    
    func colors(forIndex index: Int) -> Color {
        return buttonColorList[index].color
    }
}

struct ButtonStateView {
    var isToggled: Bool = false
}


struct TimeLabelView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLabelView(selectTask: "", selectTasks: [""], colorList: [.white, .black])
    }
}
