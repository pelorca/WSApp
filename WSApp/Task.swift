//
//  Post.swift
//  ListaTarefas
//
//  Created by ALOC SP08156 on 06/12/2017.
//  Copyright © 2017 ALOC SP08156. All rights reserved.
//

import Foundation
import EasyRest
import Genome


class Task: BaseModel {
    var count: Int?
    var next: Int?
    var previous: Int?
    var results: [TaskItem]?
    
    override func sequence(_ map: Map) throws {
        try count <~> map["count"]
        try next <~> map["next"]
        try previous <~> map["previous"]
        try results <~> map["results"]
  }
    
}


class TaskItem: BaseModel {
    var id: String?
    var title: String?
    var descriptionTask: String?
    var expirationDate: String?
    var isComplete: Bool = false
    var owner: String?
    
    required init() {
        
    }
    
   override func sequence(_ map: Map) throws {
        try id <~> map["id"]
        try expirationDate <~> map["expiration_date"]
        try title <~> map["title"]
        try descriptionTask <~> map["description"]
        try isComplete <~> map["is_complete"]
        try owner <~> map["owner"]
        
    }
    
}





