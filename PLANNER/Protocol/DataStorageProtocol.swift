//
//  DataStorageProtocol.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI
import RealmSwift

protocol DataStorageProtocol {
    associatedtype E
    var task: E {get set}
}

// 프로토콜
protocol RealmDataManagerDelegate: AnyObject {
    associatedtype T
    func didFetchTasks(_ object: [T])
    func didSaveTask()
    func didUpdateTask()
    func didDeleteTask()
}

protocol RealmDataManagerProtocol {
    associatedtype T
    func fetchTasks()
    func saveTask(_ object: T)
    func updateTask(_ object: T)
    func deleteTask(_ object: T)
}
