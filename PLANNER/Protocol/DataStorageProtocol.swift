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
//protocol RealmDataManagerDelegate: AnyObject {
//    associatedtype T
//    func didFetchTasks(_ object: [T])
//    func didSaveTask()
//    func didUpdateTask()
//    func didDeleteTask()
//}

//protocol RealmDataManagerDelegate {
//    associatedtype T
//    
//    func getData() -> [T]
//    func addData(_ object: T)
//    func getFilteringData(_ filter: NSPredicate) -> [T]
//    func updateData(_ filter: NSPredicate, _ completion: @escaping (T) -> ())
//    func deleteData()
//}
