//
//  PostRoute.swift
//  ListaTarefas
//
//  Created by ALOC SP08156 on 06/12/2017.
//  Copyright © 2017 ALOC SP08156. All rights reserved.
//

import Foundation
import EasyRest

enum PostRoute: Routable {
    
    case getPosts, login(username: String, password:String)
    
    var rule: Rule {
        switch self {
        case .getPosts:
            return Rule(method: .get, path: "/posts/",
                        isAuthenticable: false, parameters: [:])
        case let .login(username, password):
            return Rule(method: .post, path: "/oauth/token/", isAuthenticable: true, parameters: [.query:
                [
                    "client_id": "fztwDOHeUUCGsqR137rTE5yfWdxBWxVfyCceJloF",
                    "client_secret": "s9cJPsQ1iPPQ5FihzzxNvSv13glJ1VCrQsjhi8kQPIF1Nc3iILn07MVqCOp90O2F6xyHNPqc8lxP9p21cQxiFliIqKBjXin6DzT70I7NNujuST4NvuYyZg71Vzi09rGH",
                    "grant_type": "password",
                    "username": username,
                    "password": password
                ]
            ])
        }
    }
    
}
