//
//  MainView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI

struct MainView: View {
    @StateObject var homeViewModel = MainHomeViewModel()
    @State private var isTaskClick = false
    @State private var isTaskTimeLineEd = false
    @State private var isColorPick = false
    @State private var isTaskAdd = false
    @State private var colorIndex = 0
    @State private var taskLabel = ""
    @State private var totalTime = ""
    @State var pickColor = ""
    
    @State private var colors: [Color] = [.red.opacity(0.4), .orange.opacity(0.4), .yellow.opacity(0.4)]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                dateView
                
                ScrollView(showsIndicators: false) {
                    taskView
                    
                    historyView
                }
            }
            .padding(.horizontal, 30)
            .onAppear {
                homeViewModel.getTaskList()
            }
            
            NavigationLink(
                destination: TimeLabelView(
                    selectTask: taskLabel,
                    selectTasks: homeViewModel.taskList,
                    colorList: colors
                ),
                isActive: $isTaskTimeLineEd,
                label: {}
            )
            
            NavigationLink(
                destination: TaskEditView(),
                isActive: $isTaskAdd,
                label: {}
            )
        }
    }
    
    // task
    var taskView: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                subTitle(title: "TASK \(homeViewModel.taskList.count)")
                
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
            
            notTaskList
            
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
                    colors[colorIndex] = EnumColor.colorPick(color: pickColor)
                }
            }
        }
        .padding(.top, 50)
    }
    
    // history
    var historyView: some View {
        VStack(spacing: 12) {
            subTitle(title: "HISTORY")
            
            VStack(spacing: 15) {
                historyContentText(taskName: taskLabel, time: totalTime)
            }
        }
        .padding(.top, 25)
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
            
//            Button {
//                //
//            } label: {
//                RoundedRectangle(cornerRadius: 100)
//                    .frame(width: 50, height: 50)
//                    .foregroundColor(.gray.opacity(0.2))
//            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // Task가 없을 때 보여주는 뷰
    var notTaskList: some View {
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
}

extension MainView {
    // subTitle
    @ViewBuilder
    func subTitle(title: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
                .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 5)
    }
    
    // history content text
    @ViewBuilder
    func historyContentText(taskName: String, time: String) -> some View {
        let taskLabel = taskName
        let totalTime = ["총 소요 시간", "시작 시간", "작업이 마쳐진 시간", "작업이 활발한 시간"]
        
        Text(taskLabel)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ForEach(totalTime.indices, id: \.self) { index in
            Text("\(totalTime[index]) : \(time) 시간")
                .foregroundColor(.black)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
