//
//  RealmLocalDataBase.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/31.
//

import SwiftUI
import RealmSwift

class RealmLocalDataBase<T: Object>: ObservableObject {
    private var realm = try! Realm()
    @Published var data: Results<T>?
    
    // 데이터 추가
    func addData(_ object: T) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    // 데이터 조회
    func getData() -> T? {
        let results = realm.objects(T.self)
        if let firstObject = results.first {
            return firstObject
        } else {
            return nil
        }
    }
    
    // 데이터 수정
    func updateData(_ object: T, withProperties properties: [String: Any]) {
        try! realm.write {
            for (key, value) in properties {
                object[key] = value
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
