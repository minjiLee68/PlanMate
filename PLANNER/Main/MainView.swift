//
//  MainView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI

struct MainView: View {
    @State private var isTaskClick = false
    @State private var isTaskTimeLineEd = false
    @State private var taskLabel = ""
    @State private var totalTime = ""
    
    private let colors: [Color] = [.red.opacity(0.4), .green.opacity(0.3), .yellow.opacity(0.4)]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                dateView
                
                ScrollView(showsIndicators: false) {
                    taskView
                    
                    historyView
                }
            }
            .padding(.horizontal, 30)
            .onAppear {
                taskLabel = "TASK 0"
            }
            
            NavigationLink(
                destination: TimeLabelView(taskName: "TASK 0"),
                isActive: $isTaskTimeLineEd,
                label: {}
            )
        }
    }
    
    // task
    var taskView: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                subTitle(title: "TASK")
                
                Button {
                    isTaskTimeLineEd.toggle()
                } label: {
                    Text("편집")
                        .foregroundColor(.black)
                        .bold()
                        .font(.caption)
                }
            }
            
            ForEach(0..<3, id: \.self) { i in
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 0) {
                        Button {
                            isTaskClick.toggle()
                            taskLabel = "TASK \(i)"
                            totalTime = "\(i)"
                        } label: {
                            Text("TASK \(i)")
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Circle()
                            .frame(width: 20)
                            .foregroundColor(colors[i])
                    }
                    
                    Divider()
                }
            }
        }
        .padding(.top, 50)
    }
    
    // history
    var historyView: some View {
        VStack(spacing: 20) {
            subTitle(title: "HISTORY")
            
            VStack(spacing: 15) {
                historyContentText(taskName: taskLabel, time: totalTime)
            }
        }
        .padding(.top, 20)
    }
    
    // Date (YYYY.MM.dd)
    var dateView: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Today")
                    .foregroundColor(.black)
                    .font(.title)
                    .bold()
                
                Text("YYYY.MM.dd")
                    .foregroundColor(.black)
                    .font(.callout)
            }
            
            Spacer()
            
            Button {
                //
            } label: {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray.opacity(0.2))
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension MainView {
    // subTitle
    @ViewBuilder
    func subTitle(title: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 5)
    }
    
    // history content text
    @ViewBuilder
    func historyContentText(taskName: String, time: String) -> some View {
        let taskLabel = taskName
        let totalTime = ["총 소요 시간", "시작 시간", "작업이 마쳐진 시간", "작업이 활발한 시간"]
        
        Text(taskLabel)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ForEach(totalTime.indices, id: \.self) { index in
            Text("\(totalTime[index]) : \(time) 시간")
                .foregroundColor(.black)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
