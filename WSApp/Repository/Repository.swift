//
//  Repository.swift
//  WSApp
//
//  Created by Pelorca on 11/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import Foundation
import RealmSwift


class Repository {
    
    
    
    let realm = try! Realm(configuration:
        Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: {migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    
                }
        })
    )
    
    
    func save(data: Object) {
        try! realm.write {
        realm.add(data)
        }
    }
    
    
    func update(data: Object) {
        try! realm.write {
            realm.add(data, update: true)
        }
    }
    
     func delete(_ id:String) {
        let item = load(id)
        if item != nil {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(item!)
            }
        }
    }
    
     func load(_ id:String) -> TaskEntity? {
        let pred = NSPredicate(format: "id == %@", id)
        let item = realm.objects(TaskEntity.self).filter(pred).first
        return item
    }
    
    func selectPost() -> Results<PostEntity> {
        return realm.objects(PostEntity.self)
    }
    
    func selectTask() -> Results<TaskEntity> {
        return  realm.objects(TaskEntity.self)
    }
    
    func selectTaskNotRemoved() -> Results<TaskEntity> {
        return  realm.objects(TaskEntity.self).filter(NSPredicate(format: "removed == %@", NSNumber(booleanLiteral: false)))
            .sorted(byKeyPath: "id")
        
        
    }
    
    func selectTaskRemoved() -> Results<TaskEntity> {
        return  realm.objects(TaskEntity.self).filter(NSPredicate(format: "removed == %@", NSNumber(booleanLiteral: true)))
            .sorted(byKeyPath: "id")
    }
    
    func selectTask(_ text: String) -> Results<TaskEntity> {
        return  realm.objects(TaskEntity.self).filter(NSPredicate(format: "title LIKE[c] %@ OR descriptionTask LIKE[c] %@ AND removed == %@", "*" + text.uppercased() + "*", "*" + text.uppercased() + "*", NSNumber(booleanLiteral: false)))
            .sorted(byKeyPath: "id")

    }
    
}
