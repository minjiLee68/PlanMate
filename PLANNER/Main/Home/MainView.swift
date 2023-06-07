//
//  MainView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI

struct MainView: View {
    @StateObject var homeViewModel = MainHomeViewModel()
    
    @State private var taskList = [String]()
    @State private var colorList = [Color]()
    
    @State private var isTaskClick = false
    @State private var isColorPick = false
    @State private var isSave = false
    
    @State private var showDeleteAlert = false
    @State private var dragMode: Bool = false
    
    @State private var colorIndex = 0
    @State private var taskLabel = ""
    @State private var totalTime = ""
    @State var pickColor = ""
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                mainView
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                mainView
            }
        }
    }
    
    // main view
    var mainView: some View {
        VStack(spacing: 0) {
            dateView
            
            ScrollView(showsIndicators: false) {
                taskView
                
                HistoryView(taskLabel: $taskLabel, totalTime: $totalTime)
            }
        }
        .padding(.horizontal, 30)
        .onAppear {
            getTasks()
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
                
                editButtonLink() // 편집 버튼
            }
            
            if taskList.isEmpty {
                addButtonLink() // 추가하기 버튼
            } else {
                ForEach(0..<taskList.count, id: \.self) { i in
                    VStack(alignment: .leading, spacing: 12) {
                        
                        taskList(index: i)
                        
                        Divider()
                    }
                    .onChange(of: pickColor) { newValue in
                        isColorPick = false
                        colorUpdate(index: colorIndex)
                    }
                }
                
                addButtonLink() // 추가하기 버튼
            }

        }
        .padding(.top, 50)
    }
    
    @ViewBuilder
    func taskList(index: Int) -> some View {
        ZStack {
            gestureMode(index: index)
            
            HStack(spacing: 0) {
                Button {
                    isTaskClick.toggle()
                    taskLabel = taskList[index]
                    totalTime = "\(index)"
                } label: {
                    Text(taskList[index])
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    isColorPick.toggle()
                    colorIndex = index
                } label: {
                    Circle()
                        .frame(width: 20)
                        .foregroundColor(colorList[index])
                }
                .sheet(isPresented: $isColorPick) {
                    if #available(iOS 16.0, *) {
                        ColorPaletteView(pickColor: $pickColor)
                            .presentationDetents([.fraction(0.3)])
                    } else {
                        // Fallback on earlier versions
                        ZStack {
                            ColorPaletteView(pickColor: $pickColor)
                            Color.black.opacity(0.7)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    isColorPick = false
                                }
                        }
                    }
                }
            }
            .background(Color.white)
            .modifier(DraggableModifier(direction: .horizontal, showDeleteAlert: $showDeleteAlert, dragMode: $dragMode))
        }
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
        .padding(.top, 10)
    }
}

extension MainView {
    // Navigation Link
    @ViewBuilder
    func editButtonLink() -> some View {
        NavigationLink(
            destination: TimeLabelView(
                selectTask: taskLabel,
                selectTasks: taskList,
                selectColors: colorList
            ),label: {
                Text("편집")
                    .foregroundColor(.black)
                    .bold()
                    .font(.caption)
                    .opacity(taskList.isEmpty ? 0 : 1)
            }
        )
    }
    
    @ViewBuilder
    func addButtonLink() -> some View {
        NavigationLink(
            destination: TaskEditView(isSave: $isSave), label: {
                HStack {
                    Text("추가하기")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        )
    }
    
    @ViewBuilder
    func gestureMode(index: Int) -> some View {
        if !taskList.isEmpty {
            GeometryReader { geo in
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showDeleteAlert.toggle()
                        dragMode.toggle()
                        
                        homeViewModel.deleteTask(task: taskList[index])
                        
                        taskList.remove(at: index)
                    }, label: {
                        Text("삭제 \(index)")
                    })
                    .frame(width: 60)
                }
                .frame(height: geo.size.height)
            }
        }
    }
    
    func getTasks() {
        taskList = homeViewModel.getTaskList()
        colorList = homeViewModel.getColorList()
        taskLabel = taskList.first ?? ""
    }
    
    func colorUpdate(index: Int) {
        colorList[index] = EnumColor.colorPick(color: pickColor)
        homeViewModel.colorUpdate(task: taskList[index], color: pickColor)
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
