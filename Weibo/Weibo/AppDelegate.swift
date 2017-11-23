//
//  AppDelegate.swift
//  Weibo
//https://www.baidu.com/link?url=J8NNuxG2uenbHG5YRyMM4l1uWG2rjzYlxyBMuDzE8oBHoga2GbH7XUNVIy9Zj4zKdeKQXXUt9pIGlWWyUe0r3f3_tkEfOlNStIx7UK83Hst91mocF1ILNl4pedtu90sP&wd=&eqid=c49871a100006936000000065a156e58
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //应用程序额外设置
        setupAdditions()
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        loadAppInfo()
        
        return true
    }


}
// MARK: -设置额外信息
extension AppDelegate{
    private func setupAdditions(){
        //1设置提示语的显示时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        //2设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        //3设置提示授权
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound,.badge,.carPlay]) { (success, error) in
//                print("授权" + (success ? "成功" : "失败"))
            }
        } else {
            // Fallback on earlier versions
            let notifySettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
            
        }
        
        // AppDelegate 进行全局设置

        
    
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
            
        }
        
        
        
        
        
    }
    
    
    
}


