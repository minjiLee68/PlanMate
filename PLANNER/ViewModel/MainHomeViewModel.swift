//
//  MainHomeViewModel.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/31.
//

import SwiftUI

class MainHomeViewModel: ObservableObject {
    let realmLocalDataBase = RealmLocalDataBase<Task>()
    @Published var colors = [Color]()
    @Published var taskList = [String]()
//    @Published var colorList = [String]()
//    @Published var taskList = [String]()
    
    // task 데이터 가져오기
    func getTaskList() -> [String] {
        let data = realmLocalDataBase.getData()
        let taskArray = Array(data.map { $0.task })
        return taskArray
    }
    
    // color 데이터 가져오기
    func getColorList() -> [Color] {
        let data = realmLocalDataBase.getData()
        let colorArray = Array(data.map({$0.color}))
        colorArray.forEach { color in
            if colors.count != colorArray.count {
                colors.append(EnumColor.colorPick(color: color))
            }
        }
        return colors
    }
    
    // color update
    func colorUpdate(task: String, color: String) {
        realmLocalDataBase.updateData(dataFilter("task", task)) { task in
            task.color = color
        }
    }
    
    // task delete
    func deleteTask(task: String) {
        realmLocalDataBase.deleteData(dataFilter("task", task))
    }
    
    func dataFilter(_ format: String, _ args: CVarArg) -> NSPredicate {
        return realmLocalDataBase.dataFiltering(format: format, args: args)
    }
}
