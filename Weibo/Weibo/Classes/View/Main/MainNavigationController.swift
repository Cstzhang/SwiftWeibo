//
//  MainNavigationController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    //重写 pushViewController方法 所有push动作都会调用次方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        print(viewController)
        //判断是不是栈底控制器，根控制器不需要处理
        if childViewControllers.count > 0{
         //隐藏底部的tabbar
         viewController.hidesBottomBarWhenPushed=true
        }
        
        super.pushViewController(viewController, animated: true)
    }
    

}
