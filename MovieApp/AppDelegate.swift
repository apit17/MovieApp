//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Apit on 3/6/18.
//  Copyright © 2018 Apit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabbarController = MainTabBarViewController()
        tabbarController.tabBarItem = UITabBarItem()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nowPlaying = storyboard.instantiateViewController(withIdentifier: "NowPlayingViewController") as! NowPlayingViewController
        nowPlaying.title = "Now Playing"
        let upcoming = storyboard.instantiateViewController(withIdentifier: "NowPlayingViewController") as! NowPlayingViewController
        upcoming.title = "Upcoming"
        let popular = storyboard.instantiateViewController(withIdentifier: "NowPlayingViewController") as! NowPlayingViewController
        popular.title = "Popular"
        tabbarController.tabBar.barTintColor = UIColor(red: 87.0/255.0, green: 20.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        tabbarController.viewControllers = [nowPlaying, upcoming, popular]
        let navigationController = UINavigationController(rootViewController: tabbarController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black as Any]
        navigationController.navigationBar.barTintColor = UIColor(red: 87.0/255.0, green: 20.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        navigationController.title = tabbarController.title
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
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
    }


}

