//
//  MainHomeViewModel.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/31.
//

import SwiftUI

class MainHomeViewModel: ObservableObject {
    let realmLocalDataBase = RealmLocalDataBase<Task>()
    @Published var taskList = [String]()
    @Published var colorList = [String]()
//    @Published var taskList = [String]()
    
    // task 데이터 가져오기
    func getTaskList() {
        let data = realmLocalDataBase.getData()
        let tasks = Array(data.map { $0.task })
        let colors = Array(data.map {$0.color})
        taskList = tasks
        colorList = colors
    }
    
    // color update
    func colorUpdate(filterName: String, filter: String, color: String) {
        realmLocalDataBase.updateData(filterName: filterName, filter: filter) { task in
            task.color = color
        }
    }
}
