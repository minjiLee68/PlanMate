//
//  TaskEditViewModel.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI


class TaskEditViewModel: ObservableObject {
    @Published var realmLocalDataBase = RealmLocalDataBase<Task>()
    
    // task 데이터 추가
    func setTask(task: String) {
        let newTask = Task()
        newTask.task = task
        realmLocalDataBase.addData(newTask)
    }
    
    // task 데이터 가져오기
    func getTaskList() -> [Task] {
        let data = realmLocalDataBase.getData()
        let taskList = Array(data.map { $0 })
        return taskList
    }
    
    // task 데이터 수정

    // 모든 task 데이터 삭제
    func deleteTask() {
        realmLocalDataBase.deleteData(Task.self)
    }
}
