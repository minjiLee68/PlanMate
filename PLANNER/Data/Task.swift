//
//  Task.swift
//  PLANNER
//
//  Created by 이민지 on 2023/05/30.
//

import SwiftUI
import RealmSwift


class Task: Object, DataStorageProtocol {
    typealias E = String
    @Persisted var task: E
    @Persisted var color: String = "gray"
    @Persisted var taskTime: RealmSwift.List<Time> = RealmSwift.List<Time>()
}

class Time: Object {
    @Persisted var hour: Int
    @Persisted var time: Int
}
