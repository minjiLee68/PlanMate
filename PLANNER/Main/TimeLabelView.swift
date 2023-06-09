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
    @State var selectColors: [Color]
    @State private var color: Color = .white
    private let timeText = 6..<24
    private let timeTextWidth: CGFloat = 40
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    NavigationBarView(
                        naviTitle: "",
                        enumNavi: .back)
                    
                    pickerView()
                }
                
                timeLabelButtonView()
            }
            .onChange(of: selectTask) { newValue in
                for i in selectTasks.indices {
                    if selectTask == selectTasks[i] {
                        color = selectColors[i]
                    }
                }
            }
            .onAppear {
                if let color = selectColors.first {
                    self.color = color
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    func pickerView() -> some View {
        Picker("selectTask", selection: $selectTask) {
            ForEach(selectTasks, id: \.self) { task in
                HStack(spacing: 0) {
                    Text(task)
                    
                    Spacer()
                    
                    Circle()
                        .frame(width: 20)
                        .foregroundColor(color)
                }
            }
        }
        .pickerStyle(.automatic)
        .accentColor(.black.opacity(0.7))
        .font(.callout)
        .cornerRadius(5)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    @ViewBuilder
    func timeLabelButtonView() -> some View {
        ForEach(timeText, id: \.self) { i in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("\(i)")
                        .foregroundColor(.black)
                        .padding(.horizontal, 5)
                        .frame(width: timeTextWidth)
                    
                    ButtonView(selectTask: $selectTask, color: $color, timeHour: timeText[i])
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
            }
        }
    }
}

struct ButtonView: View {
    @StateObject var timeLabelViewModel = TimeLabelViewModel()
    @Binding var selectTask: String
    @Binding var color: Color
    @State var timeHour: Int
    @State private var buttonList = [false, false, false, false]
    @State private var buttonColorList = [Color]()
    @State private var draggedColumnIndex: Int = 0
    let timeCheckButtonCount = 0..<5
    
    var body: some View {
        ForEach(buttonList.indices, id: \.self) { index in
            Button {
                buttonList[index].toggle() // 버튼 색상을 변경하기 위해 toggle 사용
                buttonColorListAppend(index: index) // 색상 업데이트
                timeLabelCheck(index: index)
            } label: {
                RoundedRectangle(cornerRadius: 0)
                    .fill(buttonList[index] ? colors(forIndex: index) : Color.gray.opacity(0.1))
            }
//            .frame(width: 80)
            .padding(.vertical, 4)
            .onAppear {
                getTimeLabelColor()
            }
//            .simultaneousGesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged { value in
//                        let dragPosition = value.location
//                        let dragPositionInt = Int(dragPosition.x)
//                        let columnIndex = dragPositionInt / 60
//
//                        if columnIndex != draggedColumnIndex && columnIndex < buttonList.count {
//                            draggedColumnIndex = columnIndex
//                            buttonList[columnIndex].toggle() // 드래그 동작 시 버튼 색상을 변경
//                            testColorData() // 색상 업데이트
//                        }
//                    }
//            )
        }
    }
    
    func buttonColorListAppend(index: Int) {
        buttonColorList[index] = color
    }
    
    func colors(forIndex index: Int) -> Color {
        return buttonColorList[index]
    }
    
    func timeLabelCheck(index: Int) {
        if buttonList[index] == true {
            timeLabelViewModel.timeLabel += 1
            timeLabelViewModel.timeHour = timeHour
            timeLabelViewModel.setTime(selectTask)
        } else {
            timeLabelViewModel.timeLabel -= 1
            timeLabelViewModel.timeHour = timeHour
            timeLabelViewModel.setTime(selectTask)
        }
    }
    
    func getTimeLabelColor() {
        buttonColorList = Array(repeating: .white, count: buttonList.count)
        let tasks = timeLabelViewModel.getTaskList()
        var taskInt: Int = 0
        for task in tasks {
            for taskTime in task.taskTime {
                guard timeHour == taskTime.hour else { continue }
                timeLabelViewModel.timeLabel = taskTime.time
                
                if taskTime.time < taskInt {
                    for i in taskTime.time..<taskInt {
                        buttonColorList[i] = EnumColor.colorPick(color: task.color)
                        buttonList[i] = true
                    }
                    return
                }
                
                for i in taskInt..<taskTime.time {
                    taskInt = taskTime.time
                    buttonColorList[i] = EnumColor.colorPick(color: task.color)
                    buttonList[i] = true
                }
            }
        }
    }
}


struct TimeLabelView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLabelView(selectTask: "", selectTasks: [""], selectColors: [.gray])
    }
}
