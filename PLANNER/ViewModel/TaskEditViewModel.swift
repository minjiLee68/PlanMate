//
//  TaskEditViewModel.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI


class TaskEditViewModel: ObservableObject {
    var realmLocalDataBase = RealmLocalDataBase<Task>()
    @Published var oldTaskList = [String]()
    
    // task 데이터 추가
    func setTask(task: String) {
        let newTask = Task()
        newTask.task = task
        realmLocalDataBase.addData(newTask)
        print("newTask \(newTask)")
    }
    
    // task 데이터 가져오기
    func getTaskList() {
        let data = realmLocalDataBase.getData()
        let taskList = Array(data.map { $0.task })
        oldTaskList = taskList
    }
    
    // task 데이터 수정
    func updateTask(task: String) {
        realmLocalDataBase.updateData(dataFilter("task", task)) { t in
            t.task = task
        }
    }

    // 모든 task 데이터 삭제
    func deleteTask(task: String) {
        realmLocalDataBase.deleteData(dataFilter("task", task))
    }
    
    func dataFilter(_ format: String, _ args: CVarArg) -> NSPredicate {
        return realmLocalDataBase.dataFiltering(format: format, args: args)
    }
}
