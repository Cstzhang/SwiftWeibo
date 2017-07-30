//
//  AppDelegate.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(2)
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        return true
    }


}

