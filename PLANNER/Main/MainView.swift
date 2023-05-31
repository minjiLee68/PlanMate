//
//  MainView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI

struct MainView: View {
    @StateObject var homeViewModel = MainHomeViewModel()
    @State private var colors = [Color]()
    
    @State private var isTaskClick = false
    @State private var isTaskTimeLineEd = false
    @State private var isColorPick = false
    @State private var isTaskAdd = false
    @State private var isSave = false
    
    @State private var colorIndex = 0
    @State private var taskLabel = ""
    @State private var totalTime = ""
    @State var pickColor = ""

    var body: some View {
        NavigationStack {
            self.navigationLink()
            
            VStack(spacing: 0) {
                dateView
                
                ScrollView(showsIndicators: false) {
                    taskView
                    
                    HistoryView(taskLabel: $taskLabel, totalTime: $totalTime)
                }
            }
            .padding(.horizontal, 30)
        }
        .onAppear {
            getTasks()
            colorInit()
        }
        .onChange(of: isSave) { newValue in
            if newValue {
                getTasks()
            }
        }
    }
    
    // task
    var taskView: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                SubTitle(title: "TASK")
                
                Button {
                    if let firstTask = homeViewModel.taskList.first {
                        taskLabel = String(describing: firstTask)
                    } else {
                        taskLabel = ""
                    }

                    isTaskTimeLineEd.toggle()
                    
                } label: {
                    Text("편집")
                        .foregroundColor(.black)
                        .bold()
                        .font(.caption)
                }
                .opacity(homeViewModel.taskList.isEmpty ? 0 : 1)
            }
            
            ForEach(homeViewModel.taskList.indices, id: \.self) { i in
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 0) {
                        Button {
                            isTaskClick.toggle()
                            taskLabel = homeViewModel.taskList[i]
                            totalTime = "\(i)"
                        } label: {
                            Text(homeViewModel.taskList[i])
                                .foregroundColor(.black)
                        }

                        Spacer()

                        Button {
                            isColorPick.toggle()
                            colorIndex = i
                        } label: {
                            Circle()
                                .frame(width: 20)
                                .foregroundColor(colors[i])
                        }
                        .sheet(isPresented: $isColorPick) {
                            ColorPaletteView(pickColor: $pickColor)
                                .presentationDetents([.fraction(0.3)])
                        }
                    }

                    Divider()
                }
                .onChange(of: pickColor) { newValue in
                    isColorPick = false
                    colorUpdate(index: colorIndex)
                }
            }
            
            Button {
                isTaskAdd.toggle()
            } label: {
                HStack {
                    Text("추가하기")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        }
        .padding(.top, 50)
    }
    
    // Date (YYYY.MM.dd)
    var dateView: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Today")
                    .foregroundColor(.black)
                    .font(.title)
                    .bold()
                
                Text(ShareVar.dateFormatter.string(from: Date()))
                    .foregroundColor(.black)
                    .font(.callout)
            }
            
            Spacer()

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension MainView {
    // Navigation Link
    @ViewBuilder
    func navigationLink() -> some View {
        NavigationLink(
            destination: TimeLabelView(
                selectTask: taskLabel,
                selectTasks: homeViewModel.taskList,
                selectColors: colors
            ),
            isActive: $isTaskTimeLineEd,
            label: {}
        )
        
        NavigationLink(
            destination: TaskEditView(isSave: $isSave),
            isActive: $isTaskAdd,
            label: {}
        )
    }
    
    func getTasks() {
        homeViewModel.getTaskList()
    }
    
    func colorInit() {
        for i in homeViewModel.taskList.indices {
            colors.append(EnumColor.colorPick(color: homeViewModel.colorList[i]))
        }
    }
    
    func colorUpdate(index: Int) {
        colors[index] = EnumColor.colorPick(color: pickColor)
        homeViewModel.colorUpdate(filterName: "task", filter:  homeViewModel.taskList[index], color: pickColor)
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
