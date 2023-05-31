//
//  TimeLabelViewModel.swift
//  PLANNER
//
//  Created by 이민지 on 2023/06/01.
//

import SwiftUI

class TimeLabelViewModel: ObservableObject {
    let realmLocalDataBase = RealmLocalDataBase<Task>()
    @Published var timeLabel: Int = 0
    
    // task 데이터 가져오기
    func getTaskList() {
        let data = realmLocalDataBase.getData()
        data.forEach { task in
            timeLabel = task.taskTime
        }
    }
}
