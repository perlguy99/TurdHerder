//
//  AppDelegate.swift
//  Turd Herder
//
//  Created by Brent Michalski on 7/6/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import UIKit

let sceneWidth  = CGFloat(2048.0)
let sceneHeight = CGFloat(1536.0)

var gameSoundOn: Bool {
    get {
        return UserDefaults.standard.bool(forKey: HUDKeys.soundState)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: HUDKeys.soundState)
        UserDefaults.standard.synchronize()
    }
}

var gameMusicOn: Bool {
    get {
        return UserDefaults.standard.bool(forKey: HUDKeys.musicState)
    }
    set {
        UserDefaults.standard.set(newValue, forKey: HUDKeys.musicState)
        UserDefaults.standard.synchronize()
    }
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var backgroundStartTime: Date?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set our sound and music default values to true
        UserDefaults.standard.register(defaults: [HUDKeys.musicState: true])
        UserDefaults.standard.register(defaults: [HUDKeys.soundState: true])
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
         backgroundStartTime = Date()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        backgroundStartTime = Date()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        let now = Date()
        
//        if backgroundStartTime?.timeIntervalSince(Date()) 
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

