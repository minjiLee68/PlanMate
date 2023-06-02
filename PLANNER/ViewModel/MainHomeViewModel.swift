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
    @Published var colorList = [String]()
//    @Published var taskList = [String]()
    
    // task 데이터 가져오기
    func getTaskList() {
        let data = realmLocalDataBase.getData()
        let taskArray = Array(data.map { $0.task })
        let colorArray = Array(data.map { $0.color })
        taskList = taskArray
        colorList = colorArray
        colorList.forEach { color in
            if colors.count != colorList.count {
                colors.append(EnumColor.colorPick(color: color))
            }
        }
    }
    
    // color update
    func colorUpdate(task: String, color: String) {
        realmLocalDataBase.updateData(NSPredicate(format: "task == %@", task)) { task in
            task.color = color
        }
    }
}
