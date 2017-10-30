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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", fontSize: 14, target: self, action: #selector(autoFill), isBack: true)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectURL)"
        
        guard  let url = URL(string: urlString) else{
            return
        }
       //创建请求
       let  request = URLRequest(url: url)
       //加载请求
       webView.loadRequest(request)
        


    }

    // MARK: -监听方法
    @objc private func loginClose(){
        dismiss(animated: true, completion: nil)
    }

    //自动填充，修改美的缓存中浏览器的页面
    @objc private func autoFill(){
        //准备js
        let js = "document.getElementById('userId').value = '835066041@qq.com';" +
                 "document.getElementById('passwd').value = 'Zzb4ever';"
        //执行js
        webView.stringByEvaluatingJavaScript(from: js)
        
        
        
    }

}
