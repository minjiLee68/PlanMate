//
//  DataStorageProtocol.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI

protocol DataStorageProtocol {
    associatedtype E
    var data: E {get set}
}

// 프로토콜 정의
//protocol TaskEditDelegate {
//    func didSaveTask()
//    func getTaskAddValue() -> Bool
//}

class TaskSaveDelegateImpl {
    var isTaskAdd = false
    
    func didSaveTask() {
        isTaskAdd.toggle()
    }
    
    func getTaskAddValue() -> Bool {
        isTaskAdd.toggle()
        return isTaskAdd
    }
}
