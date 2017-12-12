//
//  PostService.swift
//  ListaTarefas
//
//  Created by ALOC SP08156 on 06/12/2017.
//  Copyright © 2017 ALOC SP08156. All rights reserved.
//

import Foundation
import EasyRest

class TaskService: Service<TaskRoute> {
    
    override var base: String { return Constants.kHttpEndpoint }
    
    override var interceptors: [Interceptor]? {
        get {
            return [AuthInterceptor()]
        }
    }
    
    func getTask(onSuccess: @escaping (Response<Task>?) -> Void,
               onError: @escaping (RestError?) -> Void,
               always: @escaping () -> Void) {
        try! call(.getTask(), type: Task.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }
    
    func delete(id: String,onSuccess: @escaping (Response<Task>?) -> Void,
                onError: @escaping (RestError?) -> Void,
                always: @escaping () -> Void) {
        try! call(.delete(id: id), type: Task.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }
    func insert(task: TaskItem,onSuccess: @escaping (Response<TaskItem>?) -> Void,
                onError: @escaping (RestError?) -> Void,
                always: @escaping () -> Void) {
        try! call(.insert(task: task), type: TaskItem.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }
    func update(task: TaskItem,onSuccess: @escaping (Response<TaskItem>?) -> Void,
                onError: @escaping (RestError?) -> Void,
                always: @escaping () -> Void) {
        try! call(.update(task: task), type: TaskItem.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }
}


