//
//  PostRoute.swift
//  ListaTarefas
//
//  Created by ALOC SP08156 on 06/12/2017.
//  Copyright © 2017 ALOC SP08156. All rights reserved.
//

import Foundation
import EasyRest

enum TaskRoute: Routable {
    
    case getTask(), delete(id: String), update(task: TaskItem), insert(task: TaskItem)
    
    var rule: Rule {
        switch self {
        case .getTask():
           return Rule(method: .get,  path: "/v1/tasks/", isAuthenticable: true,parameters: [:])
         case let .delete(id):
            return Rule(method: .delete,  path: "/v1/tasks/" + id + "/", isAuthenticable: true,parameters: [:])
        case let .insert(task):
            return Rule(method: .post,  path: "/v1/tasks/", isAuthenticable: true,parameters: [.body: task])
        case let .update(task):
            return Rule(method: .put,  path: "/v1/tasks/" + task.id! + "/", isAuthenticable: true,parameters: [.body: task])
        }
     }
    
}

