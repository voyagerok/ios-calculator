//
//  AppDelegate.swift
//  ios-calculator
//
//  Created by Николай on 06.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var pathToHistoryArchive: String!
    var expressionHandle: ExpressionHandle!
    var unaryExpressionHandle: UnaryExpressionHandle!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        pathToHistoryArchive = documentsDir?.absoluteString.appending("CalculatorHistory")
        
        if let archivedData = UserDefaults.standard.object(forKey: "calcHistory") {
            expressionHandle = NSKeyedUnarchiver.unarchiveObject(with: archivedData as! Data) as! ExpressionHandle
            NSLog("Expression handle unarchived")
        }
        else {
            expressionHandle = ExpressionHandle()
            NSLog("Expression handle gets default value")
        }
////        if let unarchivedObject = NSKeyedUnarchiver.unarchiveObject(withFile: pathToHistoryArchive) {
////        if let 
////            expressionHandle = unarchivedObject as! ExpressionHandle
////            NSLog("Expression handle unarchived")
////        }
////        else {
//            expressionHandle = ExpressionHandle()
//            NSLog("Expression handle gets default value")
////        }
        unaryExpressionHandle = UnaryExpressionHandle()
        
        let navigationVC = window?.rootViewController as! UINavigationController
        let mainViewController = navigationVC.topViewController as! ViewController
        mainViewController.expressionHandle = expressionHandle
        mainViewController.unaryExpressionHandle = unaryExpressionHandle
        
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
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//        NSKeyedArchiver.archiveRootObject(expressionHandle, toFile: pathToHistoryArchive)
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: expressionHandle)
        UserDefaults.standard.set(archivedData, forKey: "calcHistory")
        NSLog("Archiving expressionHandle")
    }


}

