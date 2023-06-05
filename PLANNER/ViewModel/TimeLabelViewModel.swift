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
    func setTime(_ task: String) {
        let time = Time()
        time.hour = self.timeHour
        time.time = self.timeLabel
        
        realmLocalDataBase.updateData(dataFilter("task", task)) { task in
            task.taskTime.append(time)
        }
    }
    
    func timeUpdate(_ task: String) {
        realmLocalDataBase.updateData(dataFilter("task", task)) { task in
            task.taskTime.forEach { t in
                if t.time > self.timeLabel {
                    t.time = self.timeLabel
                }
            }
        }
    }
    
    // task 데이터 가져오기
    func getTaskList(_ task: String) -> [Task] {
        let filteringData = realmLocalDataBase.getFilteringData(dataFilter("task", task))
        return filteringData.map({$0})
    }
    
    func dataFilter(_ format: String, _ args: CVarArg) -> NSPredicate {
        return realmLocalDataBase.dataFiltering(format: format, args: args)
    }
}
