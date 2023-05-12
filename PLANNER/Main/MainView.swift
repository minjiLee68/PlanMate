//
//  MainView.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        VStack(spacing: 0) {
            dateView
            
            taskView
            
            Spacer()
        }
        .padding(.horizontal, 30)
    }
    
    // timeTable
//    var TimeTable: some View {
//
//    }
    
    // task
    var taskView: some View {
        VStack {
            HStack {
                Text("TASK")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            List {
                Text("task1")
                    .listRowInsets(.init())
                Text("task2")
                    .listRowInsets(.init())
                Text("task3")
                    .listRowInsets(.init())
                Text("task4")
                    .listRowInsets(.init())
                Text("task5")
                    .listRowInsets(.init())
            }
            .listStyle(.plain)
        }
        .padding(.top, 50)
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
                    .foregroundColor(.green.opacity(0.5))
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
