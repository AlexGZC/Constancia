
//
//  AppDelegate.swift
//  beerapp
//
//  Created by elaniin on 1/19/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import SwiftyBeaver
import FBSDKLoginKit
import FBSDKCoreKit

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.sharedManager().enable = true
        
        //Delegating console
        let console = ConsoleDestination()  // log to Xcode Console
        
        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss$d $L $M"
        // or use this for JSON output: console.format = "$J"
        
        // add the destinations to SwiftyBeaver
        log.addDestination(console)
        
        //set emojis
        console.levelString.verbose = "❤️ VERBOSE: "
        console.levelString.debug = "🏃🏻 DEBUG: "
        console.levelString.info = "✍🏻 INFO: "
        console.levelString.warning = "⚠️ WARNING"
        console.levelString.error = "😡 ERROR"
        
        //Facebook delegate
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            print("dd")
        }
        
        
        
            let launchStoryBoard = UIStoryboard.init(name: "Session", bundle: nil)
            // Get the splash screen controller
            
            let splashController = launchStoryBoard.instantiateViewController(withIdentifier: "LottieControllerID")

            self.window?.rootViewController = splashController
        
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.dismissSplashController), userInfo: nil, repeats: false)
        
        
        
        return true
    }
    
    
    @objc private func dismissSplashController() {
        // Get a refernce to Main.storyboard
        let mainStoryBoard = UIStoryboard.init(name: "Session", bundle: nil)
        // Get initial viewController
        let initController = mainStoryBoard.instantiateViewController(withIdentifier: "firstResponderControllerID")
        // Assign it to rootViewController
        self.window?.rootViewController = initController
        self.window?.makeKeyAndVisible()
        
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
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
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "beerapp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    

}

