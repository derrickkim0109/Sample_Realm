//
//  Translation.swift
//  Sample_Realm
//
//  Created by Derrickk Kim on 7/1/24.
//

import RealmSwift

final class Translation: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var age: Int = 0
    
    convenience init(id: Int, name: String, age: Int) {
        self.init()
        self.id = id
        self.name = name
        self.age = age
    }
    
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}
