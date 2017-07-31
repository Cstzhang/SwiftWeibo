//
//  MainViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildController()
    }
    
    
}
/* extension类似oc分类，切分代码块
   可以把相近功能的函数放在一个extension中便于维护
   extension扩展只能添加些的计算属性，但不能添加存储属性，也不能像已有属性添加属性观察
 */
private extension MainViewController {

    //设置所有子控制器
     func setupChildController(){
        let array = [
           ["clsName":"HomeViewController","title":"首页","imageName":"home"],
           ["clsName":"MessageViewController","title":"消息","imageName":"message_center"],
           ["clsName":"DiscoverViewController","title":"发现","imageName":"discover"],
           ["clsName":"ProfileViewController","title":"我","imageName":"profile"],
        
        ]
        var arrarM = [UIViewController]()
        for dict in array {
            //把生成的控制器加入数组
            arrarM.append(controller(dict: dict))
        }
        viewControllers = arrarM
        
    }
    
    //使用字典创建一个子控制器
    // dict: clsName titile imageName
    
     func controller(dict:[String:String])->UIViewController{
        //1，取得字典内容
        guard let clsName =   dict["clsName"],
            let title =     dict["title"],
            let imageName =  dict["imageName"],
            let cls = NSClassFromString(Bundle.main.namespace+"."+clsName) as? UIViewController.Type
            else{
                return UIViewController()
        }
        //2，创建视图控制器
        let vc = cls.init()
        vc.title = title
        //3, 设置图标
        vc.tabBarItem.image = UIImage(named: "tabbar_"+imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_"+imageName+"_selected")?.withRenderingMode(.alwaysOriginal)
        //4,设置标题样式
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange],
                                             for: .highlighted)
         //系统默认12号字 ，要设置normal 字体大小
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12)],
                                             for: UIControlState.normal)
        
        
        let nav = MainNavigationController(rootViewController: vc)
        return nav
        
        
    }
    
    
}

