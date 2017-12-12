//
//  AuthInterceptor.swift
//  WSApp
//
//  Created by Pelorca on 07/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import Foundation
import EasyRest
import Alamofire
import Genome


class AuthInterceptor: Interceptor {
    
    required init() {}
   
    func requestInterceptor<T: NodeInitializable>(_ api: API<T>) {
        if Repository().selectPost().count == 1  {
            let str = Repository().selectPost()[0].accessToken!
            api.headers["Authorization"] = "Bearer \(str)"
        }
    }
 
    func responseInterceptor<T>(_ api: API<T>, response: DataResponse<Any>) where T : NodeInitializable {
        
    }
    
    
}
