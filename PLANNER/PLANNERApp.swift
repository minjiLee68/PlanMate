//
//  PLANNERApp.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/12.
//

import SwiftUI
import RealmSwift

@main
struct PLANNERApp: SwiftUI.App {
    init() {
        // Realm 마이그레이션 설정
        let config = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 4 {
                    migration.enumerateObjects(ofType: Task.className()) { oldObject, newObject in
                        newObject?["color"] = "defaultColor" // 예시로 새로운 속성 추가
                        newObject?["taskTime"] = [Time]() // 예시로 새로운 속성 추가
                    }
                }
            }
        )
        
        // Realm 구성 설정
        Realm.Configuration.defaultConfiguration = config
        
        // Dark 모드 비활성화
        if #available(iOS 15.0, *) {
            UITraitCollection.current = UITraitCollection(userInterfaceStyle: .light)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
