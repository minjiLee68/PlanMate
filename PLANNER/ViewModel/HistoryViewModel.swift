//
//  HistoryViewModel.swift
//  PLANNER
//
//  Created by 이민지 on 2023/06/07.
//

import SwiftUI

class HistoryViewModel: ObservableObject {
    let realmLocalDataBase = RealmLocalDataBase<Task>()
    @Published var getTimeContent = [String]()
    
    // 총 소요 시간
    func getTaskTime(_ task: String) {
        let data = realmLocalDataBase.getFilteringData(dataFilter("task", task))
        
        data.forEach { task in
            let timeData = Array(task.taskTime)
            
            getTimeContent = [
                getTotalTime(timeData),
                getStartTime(timeData),
                getEndTime(timeData),
                getPeakHours(timeData)
            ]
        }
    }
    
    func getTotalTime(_ data: [Time]) -> String {
        var total = 0
        var timeText = ""
        var totalDuration = 0
        
        for time in data {
            total += time.time * 15
            if total > 60 {
                totalDuration = total / 60
                timeText = "시간"
            } else {
                totalDuration = total
                timeText = "분"
            }
        }
        return "총 소요 시간 : \(totalDuration) \(timeText)"
    }
    
    func getStartTime(_ data: [Time]) -> String {
        var startTime = data.first?.hour ?? 0
        for time in data {
            if startTime > time.hour {
                startTime = time.hour
            }
        }
        if startTime > 12 {
            startTime -= 12
            return "시작 시간 : 오후 \(startTime) 시"
        }
        
        return "시작 시간 : 오전 \(startTime) 시"
    }
    
    func getEndTime(_ data: [Time]) -> String {
        var endTime = data.first?.time ?? 0
        for time in data {
            if endTime < time.hour {
                endTime = time.hour
            }
        }
        if endTime > 12 {
            endTime -= 12
            return "작업이 마쳐진 시간 : 오후 \(endTime) 시"
        }
        
        return "작업이 마쳐진 시간 : 오전 \(endTime) 시"
    }
    
    func getPeakHours(_ data: [Time]) -> String {
        var firstPeakTime = 0
        var lastPeakTime = 0
        var peak = 0
        
        for time in data {
            if peak != time.time && peak < time.time {
                peak = time.time
                firstPeakTime = time.hour
            }
            if peak == time.time {
                lastPeakTime = time.hour
            }
        }
        if firstPeakTime > 12 && lastPeakTime > 12 {
            firstPeakTime -= 12
            lastPeakTime -= 12
            return "작업이 활발한 시간 : 오후 \(firstPeakTime) ~ \(lastPeakTime) 시"
        }
        
        return "작업이 활발한 시간 : 오전 \(firstPeakTime) ~ \(lastPeakTime) 시"
    }
    
    func dataFilter(_ format: String, _ args: CVarArg) -> NSPredicate {
        return realmLocalDataBase.dataFiltering(format: format, args: args)
    }
}
