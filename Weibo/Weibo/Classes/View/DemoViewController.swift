//
//  DemoViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/31.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class DemoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置标题
        title = "第 \(navigationController?.childViewControllers.count ?? 0) 个"
   
       
    }

    /// 继续 PUSH 一个新的控制器
    @objc fileprivate func showNext() {
        
        let vc = DemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension DemoViewController{
    //navigationItem重写 设置导航栏按钮
    override func setupUI() {
        super.setupUI()
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
        
    }

}
