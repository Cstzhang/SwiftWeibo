//
//  BaseViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
    //自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    //navItem
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //设置导航栏title 重写 title的set方法
    override var title: String? {
        didSet{
          navItem.title = title
        
        }
    
    }

}





extension BaseViewController{
      func setupUI()  {
        view.backgroundColor=UIColor.cz_random()
        //添加导航条
        view.addSubview(navigationBar)
        navigationBar.items=[navItem]
        
    }

    
}
