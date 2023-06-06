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
            if task.taskTime.isEmpty {
                task.taskTime.append(time)
            } else {
                for i in task.taskTime.indices {
                    if task.taskTime[i].hour == self.timeHour {
                        task.taskTime[i].time = self.timeLabel
                        return
                    }
                }
                task.taskTime.append(time)
            }
        }
    }
    
    // task 데이터 가져오기
    func getTaskList() -> [Task] {
        let filteringData = realmLocalDataBase.getData()
        return filteringData.map({$0})
    }
    
//    func getTaskTimeLabel(_ task: String) {
//        let data = realmLocalDataBase.getFilteringData(dataFilter("task", task))
//        let tasks = data.map({$0})
//        let filtering = tasks.filter({$0.task == task})
//        filtering.forEach { task in
//            for i in task.taskTime.indices {
//                task.taskTime[i].time
//            }
//        }
//    }
    
    func dataFilter(_ format: String, _ args: CVarArg) -> NSPredicate {
        return realmLocalDataBase.dataFiltering(format: format, args: args)
    }
}
