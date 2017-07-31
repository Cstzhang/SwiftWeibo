//
//  HomeViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @objc fileprivate  func showFriends()  {
        print("查看好友")
        let vc = DemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}


extension HomeViewController{


    //navigationItem重写 设置导航栏按钮
    override func setupUI() {
        super.setupUI()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
    }
    
}
