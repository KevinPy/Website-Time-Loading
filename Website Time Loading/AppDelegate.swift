//
//  AppDelegate.swift
//  Website Time Loading
//
//  Created by Kevin on 01/10/2015.
//  Copyright © 2015 Pirade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        if let splitViewController = self.window?.rootViewController as? UISplitViewController,
            let navigationController = splitViewController.viewControllers.last as? UINavigationController{
                
                navigationController.topViewController?.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
                splitViewController.delegate = self
        }
        
        return true
    
    }

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {}
    func applicationDidEnterBackground(application: UIApplication) {}
    func applicationWillEnterForeground(application: UIApplication) {}
    func applicationDidBecomeActive(application: UIApplication) {}
    func applicationWillTerminate(application: UIApplication) {}

}

