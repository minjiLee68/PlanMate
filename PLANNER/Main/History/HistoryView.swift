//
//  HistoryView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/31.
//

import SwiftUI

struct HistoryView: View {
    @Binding var taskLabel: String
    @Binding var totalTime: String
    
    var body: some View {
        VStack(spacing: 12) {
            SubTitle(title: "HISTORY")
            
            VStack(spacing: 15) {
                historyContentText(taskName: taskLabel, time: totalTime)
            }
        }
        .padding(.top, 20)
    }
    
    // history content text
    @ViewBuilder
    func historyContentText(taskName: String, time: String) -> some View {
        let taskLabel = taskName
        let totalTime = ["총 소요 시간", "시작 시간", "작업이 마쳐진 시간", "작업이 활발한 시간"]
        
        Text(taskLabel)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ForEach(totalTime.indices, id: \.self) { index in
            Text("\(totalTime[index]) : \(time) 시간")
                .foregroundColor(.black)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(taskLabel: .constant("TASK"), totalTime: .constant("10"))
    }
}
