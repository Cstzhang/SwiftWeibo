//
//  MainNavigationController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏默认的NavigationBar
        navigationBar.isHidden=true
    }
    
    
    //重写 pushViewController方法 所有push动作都会调用次方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        print(viewController)
        //判断是不是栈底控制器，根控制器不需要处理
        if childViewControllers.count > 0{
         //隐藏底部的tabbar
         viewController.hidesBottomBarWhenPushed=true
         //判断控制器类型 设置返回键
        if let vc = viewController as? BaseViewController {
            var title = "返回"
            //判断控制器级数
            if childViewControllers.count == 1 {
            // titile 显示首页标题
                title = childViewControllers.first?.title ?? "返回"
            }
            //设置自定义返回键
            vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent),isBack:true)
          
        }

        }
        
        super.pushViewController(viewController, animated: true)
    }

    //返回上一级
    @objc private func popToParent(){
      popViewController(animated: true)
    
    
    }
    
        
        
        
        
    
}
