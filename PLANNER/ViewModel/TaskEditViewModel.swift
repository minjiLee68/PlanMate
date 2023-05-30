//
//  TaskEditViewModel.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI

class TaskEditViewModel: ObservableObject, TaskEditDelegate {
    @Published var setTaskList = [Task]()
    @Published var task = ""
    @Published var isTaskAdd = false
    
    func didSaveTask() {
        isTaskAdd.toggle()
    }
}
