//
//  TranslationManager.swift
//  Sample_Realm
//
//  Created by Derrickk Kim on 7/1/24.
//

import RealmSwift

final class TranslationManager {
    static let shared = TranslationManager()
    private let realm = try! Realm()
    
    private init() { }
    
    func save(translations: [(id: Int, name: String, age: String)]) {
        try! realm.write {
            for translationData in translations {
                let id = translationData.id
                let name = translationData.name
                let age = Int(translationData.age) ?? 0

                if let existingTranslation = realm.objects(Translation.self).filter("id == %@", id).first {
                    existingTranslation.name = name
                    existingTranslation.age = age
                } else {
                    let translation = Translation(id: id, name: name, age: age)
                    realm.add(translation)
                }
            }
        }
    }
    
    func fetchTranslationByKey(id: Int) -> Int? {
        return realm.objects(Translation.self).filter("id == %@", id).first?.id
    }
    
    func fetchAllTranslations() -> [Translation] {
        return Array(realm.objects(Translation.self))
    }
}
