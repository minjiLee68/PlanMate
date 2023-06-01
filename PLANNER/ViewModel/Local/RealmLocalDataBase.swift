//
//  RealmLocalDataBase.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/31.
//

import SwiftUI
import RealmSwift

struct RealmLocalDataBase<T: Object> {
    private var realm = try! Realm()
    
    // 데이터 추가
    func addData(_ object: T) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    func getData() -> Results<T> {
        let results = realm.objects(T.self)
        print("realm data \(Realm.Configuration.defaultConfiguration.fileURL!)")
        return results
    }
    
    // 데이터 필터링해서 가져오기
    func getFilteringData(_ filter: NSPredicate) -> Results<T> {
        let results = realm.objects(T.self)
        return results.filter(filter)
    }
    
    // 데이터 업데이트
    func updateData(_ filter: NSPredicate, _ completion: @escaping (T) -> ()) {
        let results = realm.objects(T.self)
        let filter = results.filter(filter)
        if let filteringData = filter.first {
            try! realm.write({
                completion(filteringData)
            })
        }
    }
    
    // 데이터 삭제
    func deleteData() {
        let objects = realm.objects(T.self)
        try! realm.write {
            realm.delete(objects)
        }
    }
}
