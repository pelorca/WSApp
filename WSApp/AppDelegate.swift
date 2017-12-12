//
//  AppDelegate.swift
//  WSApp
//
//  Created by Pelorca on 06/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2916044295, green: 0.5656878948, blue: 0.8853569627, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.2916044295, green: 0.5656878948, blue: 0.8853569627, alpha: 1)
        IQKeyboardManager.sharedManager().enable = true
        sincronize()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
       
    }
    
    func sincronize() {
        
        if Constants().dispositivoOnline() {
            
            var taskItem = TaskItem()
            
            if Repository().selectTask().count == 0 {
                
                TaskService().getTask(onSuccess: { response in
                    let task = (response?.body)!
                    for item in task.results! {
                        let db = TaskEntity()
                        db.descriptionTask = item.descriptionTask
                        db.expirationDate = item.expirationDate
                        db.id =  UUID().uuidString
                        db.serverId =  item.id
                        db.removed = false
                        db.isComplete =  item.isComplete
                        db.title =  item.title
                        Repository().save(data: db)
                    }
                    
                }, onError: { _ in
                }, always: {
                    
                    
                })
                
            }
            
            for item in  Repository().selectTaskNotRemoved() {
                taskItem = TaskItem()
                taskItem.descriptionTask = item.descriptionTask
                taskItem.expirationDate = item.expirationDate
                taskItem.isComplete = item.isComplete
                taskItem.title = item.title
                
                taskItem.id = item.serverId
                
                let novoItem = TaskEntity().toEntity(item: item)
                if taskItem.id == nil {
                    TaskService().insert(task: taskItem , onSuccess: { response in
                        let task = (response?.body)!
                        novoItem.serverId = task.id
                        Repository().update(data: novoItem)
                    }, onError: { _ in
                    }, always: {
                        
                        
                    })
                    
                } else {
                    TaskService().update(task: taskItem , onSuccess: { response in
                        taskItem = (response?.body)!
                    }, onError: { _ in
                    }, always: {
                        
                    })
                }
            }
            
            for item in  Repository().selectTaskRemoved() {
                if item.serverId != nil {
                    TaskService().delete(id: item.serverId! , onSuccess: { response in
                        
                    }, onError: { _ in
                    }, always: {
                        Repository().delete(item.id!)
                    })
                    
                } else {
                    Repository().delete(item.id!)
                }
            }
            
            
        }
     }
    
    
}

