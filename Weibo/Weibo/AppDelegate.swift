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
        loadAppInfo()
        return true
    }


}

// MARK: -从服务器加载应用程序信息
extension AppDelegate {
    func loadAppInfo() -> () {
        DispatchQueue.global().async {
            //1.url
            let url = Bundle.main.url(forResource: "MainVC.json", withExtension: nil)
            //2.读取json文件中的内容
             let data = NSData(contentsOf: url!)
            //3.写入沙盒磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("MainVC.json")
            data?.write(toFile: jsonPath, atomically: true)
            print("应用程序加载完毕:\(jsonPath)")
            
            
        }
        
        
        
        
        
    }
    
    
    
}


