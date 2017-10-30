//
//  WBOAuthController.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/30.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
//通过webview 加载登录页面
class WBOAuthController: UIViewController {
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor .white
        //设置导航栏
        title = "登录新浪微博"
        //按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 14, target: self, action: #selector(loginClose), isBack: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()


    }

    // MARK: -监听方法
    @objc private func loginClose(){
        dismiss(animated: true, completion: nil)
    }

    

}
