//
//  TimeLabelViewModel.swift
//  PLANNER
//
//  Created by 이민지 on 2023/06/01.
//

import SwiftUI

class TimeLabelViewModel: ObservableObject {
    var realmLocalDataBase = RealmLocalDataBase<Task>()
    
    @Published var timeHour: Int = 0
    @Published var timeLabel: Int = 0
    
    // 데이터 업데이트
    func updateData(_ task: String) {
        let filter = NSPredicate(format: "task == %@", task)
        realmLocalDataBase.updateData(filter) { task in
            task.taskTime.forEach { time in
                if time.hour == self.timeHour {
                    time.time = self.timeLabel
                }
            }
        }
    }
    
    // task 데이터 가져오기
    func getTaskList(_ task: String) -> [Task] {
        let filter = NSPredicate(format: "task == %@", task)
        let filteringData = realmLocalDataBase.getFilteringData(filter)
        return filteringData.map({$0})
    }
}
