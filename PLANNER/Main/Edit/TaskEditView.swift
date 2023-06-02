//
//  taskEditView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI

struct TaskEditView: View {
    @Binding var isSave: Bool
    
    @StateObject var taskEditViewModel = TaskEditViewModel()
    @State var taskList = [String]()
    @State var task = ""
    @State var index = 0
    let characterLimit = 10
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                NavigationBarView (
                    isSaveButton: {
                        isSave = true
                        saveTasks()
                    },
                    naviTitle: "",
                    enumNavi: .save
                )
                
                Text("Task를 추가해보세요.")
                    .font(.headline)
                
                VStack(spacing: 10) {
                    ForEach(taskEditViewModel.oldTaskList.indices, id: \.self) { index in
                        TextField(
                            "TASK \(index + 1)",
                            text: $taskEditViewModel.oldTaskList[index]
                        )
                        .onChange(of: taskEditViewModel.oldTaskList[index]) { newValue in
                            task = newValue
                        }
                        
                        Divider()
                    }
                    
                    Button {
                        addTask()
                        newTasks()
                    } label: {
                        Text("추가하기")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.6))
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden()
            .onAppear {
                isSave = false
                getTasks()
            }
        }
    }
    
    func newTasks() {
        if task == "" {
            return 
        }
        taskList.append(task)
    }
    
    func saveTasks() {
        newTasks()
        for i in taskList.indices {
            taskEditViewModel.setTask(task: taskList[i])
        }
    }
    
    func addTask() {
        taskEditViewModel.oldTaskList.append("")
    }
    
    func getTasks() {
        taskEditViewModel.getTaskList()
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(isSave: .constant(false))
    }
}
