//
//  taskEditView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI

struct TaskEditView: View {
    @StateObject var taskEditViewModel = TaskEditViewModel()
    @State var taskList = ["", "", "", "", "", "", "", "", "", ""]
    @State var test = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            NavigationBarView(delegate: taskEditViewModel.self, naviTitle: "", enumNavi: .save)

            Text("Task를 추가해보세요.")
                .font(.headline)
            
            VStack(spacing: 10) {
                ForEach(0..<10, id: \.self) { index in
                    TextField("TASK \(index + 1)", text: $taskList[index])
                    
                    Divider()
                }
                
                Text("추가하기")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.top, 20)
                
                ForEach(taskEditViewModel.setTaskList.indices, id: \.self) { index in
                    Text(taskEditViewModel.setTaskList[index].task)
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.top, 20)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
        .onChange(of: taskEditViewModel.isTaskAdd) { newValue in
            taskList.forEach { task in
                taskEditViewModel.setTaskList.append(Task(task: task))
            }
            test = "ok"
        }
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView()
    }
}
