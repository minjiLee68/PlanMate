//
//  TaskEditViewModel.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI


class TaskEditViewModel: ObservableObject {
    @Published var realmLocalDataBase = RealmLocalDataBase<Task>()
    @Published var setTaskList = [Task]()
    @Published var task = ""
    
    // task 데이터 추가
    func setTask(tasks: [String]) {
        task.forEach { task in
            realmLocalDataBase.addData(Task(value: task))
        }
    }
    
    // task 데이터 조회
    func getTask() {
        realmLocalDataBase.getData()
        if let data = realmLocalDataBase.data {
            setTaskList.append(contentsOf: data)
        }
    }
    
    // task 데이터 수정

    // 모든 task 데이터 삭제
    func deleteTask() {
        realmLocalDataBase.deleteData(Task.self)
    }
}
