//
//  Post.swift
//  ListaTarefas
//
//  Created by ALOC SP08156 on 06/12/2017.
//  Copyright © 2017 ALOC SP08156. All rights reserved.
//

import Foundation
import RealmSwift


class PostEntity: Object {
    @objc dynamic var id: String?
    @objc dynamic var accessToken: String?
  
    override static func primaryKey() -> String {
        return "id"
    }
    
}







