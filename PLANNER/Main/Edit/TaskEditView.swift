//
//  taskEditView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI

struct TaskEditView: View {
    @Binding var isSave: Bool
    
    @StateObject private var taskEditViewModel = TaskEditViewModel()
    @State private var taskList = [String]()
    @State private var task = ""
    @State private var index = 0
    @State private var isEditUpdate = false
    let characterLimit = 10
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                NavigationBarView (
                    isSaveButton: {
                        isSave = true
                        saveTasks(index: index)
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
                            self.index = index
                        }
                        
                        Divider()
                    }
                    
                    Button {
                        addTask()
                        newTasks()
                    } label: {
                        Text("추가하기 \(task)")
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
    
    func saveTasks(index: Int) {
        newTasks()
        if taskEditViewModel.getTaskList()[index] != taskEditViewModel.oldTaskList[index] {
            taskEditViewModel.updateTask(task: taskEditViewModel.getTaskList()[index], updateTask: taskEditViewModel.oldTaskList[index])
        } else {
            for i in taskList.indices {
                taskEditViewModel.setTask(task: taskList[i])
            }
        }
    }
    
    func addTask() {
        taskEditViewModel.oldTaskList.append("")
    }
    
    func getTasks() {
        taskEditViewModel.oldTaskList = taskEditViewModel.getTaskList()
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(isSave: .constant(false))
    }
}
