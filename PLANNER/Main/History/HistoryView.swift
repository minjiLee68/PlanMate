//
//  HistoryView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/31.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    @Binding var taskLabel: String
    @Binding var totalTime: String
    
    @State var times = [Time]()
    
    var body: some View {
        VStack(spacing: 12) {
            SubTitle(title: "HISTORY")
            
            VStack(spacing: 15) {
                historyContentView()
            }
        }
        .padding(.top, 20)
        .onChange(of: taskLabel, perform: { _ in
            viewModel.getTaskTime(taskLabel)
        })
    }
    
    @ViewBuilder
    func historyContentView() -> some View {
        Text(taskLabel)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ForEach(viewModel.getTimeContent, id: \.self) { content in
            Text(content)
                .foregroundColor(.black)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    func timeContentView(_ content: String) -> some View {
        Text(content)
            .foregroundColor(.black)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(taskLabel: .constant("TASK"), totalTime: .constant("10"))
    }
}
