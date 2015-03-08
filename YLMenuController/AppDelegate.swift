//
//  AppDelegate.swift
//  YLMenuController
//
//  Created by 邱 育良 on 15/2/9.
//  Copyright (c) 2015年 Qiu Yuliang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var accountManager: AccountManager?
    var menuController: YLMenuController?
    var currentRootController: UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.accountManager = AccountManager(
            loginCallback: {
                self.applicationFramework()
            },
            logoutCallback: {
                self.showLoginViewController()
        })
//        self.accountManager!.login()
        self.accountManager!.logout()
        self.applicationTheme()
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func applicationFramework() {
        var mainController = MainViewController()
        var leftController = LeftViewController()
        var rightController = RightViewController()
        self.menuController = YLMenuController(rootViewController: mainController)
        self.menuController!.leftViewController = leftController
        self.menuController!.rightViewController = rightController
        self.currentRootController = UINavigationController(rootViewController: self.menuController!)
        self.window!.rootViewController = self.currentRootController
    }
    
    func applicationTheme() {
        UINavigationBar.appearance().barTintColor = RGBACOLOR(45, 142, 223, 1)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent;
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    }
    
    func showLoginViewController() {
        var loginViewController = LoginViewController()
        self.window!.rootViewController = loginViewController
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

