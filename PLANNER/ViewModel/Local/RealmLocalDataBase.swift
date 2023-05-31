//
//  RealmLocalDataBase.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/31.
//

import SwiftUI
import RealmSwift

class RealmLocalDataBase<T: Object> {
    private var realm = try! Realm()
    
    // 데이터 추가
    func addData(_ object: T) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    // 데이터 조회
    func getData() -> Results<T> {
        let results = realm.objects(T.self)
        print("realm data \(Realm.Configuration.defaultConfiguration.fileURL!)")
        return results
    }
    
    // 데이터 필터링해서 가져오기
    func getFilteringData(type: String, filter: String, completion: @escaping(T) -> ()) {
        let results = realm.objects(T.self)
        let filter = NSPredicate(format: "\(type) == %@", filter)
        if let filtering = results.filter(filter).first {
            try! realm.write({
                completion(filtering)
            })
        }
    }
    
    // 데이터 수정
    func updateData(filterName: String, filter: String, completion: @escaping (T) -> ()) {
        let filter = NSPredicate(format: "\(filterName) == %@", filter)

        if let taskToUpdate = realm.objects(T.self).filter(filter).first {
            try! realm.write {
                completion(taskToUpdate)
            }
        }
    }
    
    // 데이터 삭제
    func deleteData(_ object: T.Type) {
        let objects = realm.objects(object)
        try! realm.write {
            realm.delete(objects)
        }
    }
}

struct RealmDelegate<T: Object>: RealmDataManagerProtocol {
    typealias T = T
    
    func fetchTasks() {
        <#code#>
    }
    
    func saveTask(_ object: T) {
        <#code#>
    }
    
    func updateTask(_ object: T) {
        <#code#>
    }
    
    func deleteTask(_ object: T) {
        <#code#>
    }
}
