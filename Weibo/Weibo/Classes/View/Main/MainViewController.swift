//
//  MainViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//  private当前类当前代码块访问 fileprivate当前文件内访问 @objc 允许函数在“运行时”通过OC的消息机制 被调用

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildController()
        setupComposeButton()

    
        }
    //修改横竖设置 portrait 竖屏 landscape 横屏 在需要横屏的时候单独处理
    //设置支持的方向后，当前控制器以及子控制器都会遵守这个方向
    //视频播放 用modal来展示，旋转
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.portrait
    
    }
    
    //私用控件
    fileprivate lazy var composeButton : UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    //撰写微博
    @objc fileprivate func composeStatus() -> () {
        print("撰写微博")
        //测试方向旋转
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.cz_random()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true) {
        }
        
    }
    
}
/* extension类似oc分类，切分代码块
   可以把相近功能的函数放在一个extension中便于维护
   extension扩展只能添加些的计算属性，但不能添加存储属性，也不能像已有属性添加属性观察
 */
 extension MainViewController {
    //设置添加按钮
   fileprivate func setupComposeButton(){
        tabBar.addSubview(composeButton)
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count - 1//向内缩进的宽度减少，让按钮的宽度变大，盖住容错点，防止点击穿透
        composeButton.frame = tabBar.bounds.insetBy(dx: 2*w, dy: 0)
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    
    }
    //设置所有子控制器
   fileprivate  func setupChildController(){
        let array = [
           ["clsName":"HomeViewController","title":"首页","imageName":"home"],
           ["clsName":"MessageViewController","title":"消息","imageName":"message_center"],
           ["clsName":"UIViewController","title":"","imageName":""],
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

   fileprivate  func controller(dict:[String:String])->UIViewController{
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
        
        //实例化导航控制器的时候，会调用push方法将rootVC压栈
        let nav = MainNavigationController(rootViewController: vc)
        return nav
        
        
    }
    

    
}

