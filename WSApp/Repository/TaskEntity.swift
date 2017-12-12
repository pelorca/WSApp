//
//  TaskEntity.swift
//  WSApp
//
//  Created by Pelorca on 11/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import Foundation
import RealmSwift

class TaskEntity: Object {
    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var descriptionTask: String?
    @objc dynamic var expirationDate: String?
    @objc dynamic var isComplete: Bool = false
    @objc dynamic var serverId: String?
    @objc dynamic var removed: Bool = false
    
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    func toEntity(item: TaskEntity) -> TaskEntity {
        
        let task = TaskEntity()
        task.descriptionTask = item.descriptionTask
        task.expirationDate = item.expirationDate
        task.isComplete = item.isComplete
        task.title = item.title
        task.serverId =  item.serverId
        task.id = item.id
        task.removed = item.removed
        return task
   }
    
    
    
}
