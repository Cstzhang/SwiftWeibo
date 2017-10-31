//
//  WBOAuthController.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/30.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import SVProgressHUD
//通过webview 加载登录页面
class WBOAuthController: UIViewController {
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        webView.scrollView.isScrollEnabled = false
        view.backgroundColor = UIColor .white
        //设置导航栏
        title = "登录新浪微博"
        //设置代理
        webView.delegate = self
        
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
        SVProgressHUD.dismiss()
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

extension WBOAuthController:UIWebViewDelegate{
    /// webview将要加载请求
    ///
    /// - Parameters:
    ///   - webView: webView
    ///   - request: 要加载的请求
    ///   - navigationType: 导航类型
    /// - Returns: 是否加载 request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //  print("加载请求-- \(describing: request.url?.absoluteString)")
        //如果请求地址包含 WBRedirectURL 则不加载 从WBRedirectURL回调url中查找"code="获取key
        
        if request.url?.absoluteString.hasPrefix(WBRedirectURL) == false{
            return true
        }
        
        if request.url?.query?.hasPrefix("code=") == false {
           print("取消授权")
            //取消授权
            loginClose()
            return false
        }
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        
        print("获取授权码 \(String(describing: code))")
        //使用授权码获取accessToken
        NetWorkManager.shared.loadAccessToken(code: code) { (isSuccess) in
            if !isSuccess{
                SVProgressHUD.showInfo(withStatus: "网络请求失败")
            }else{
                SVProgressHUD.showInfo(withStatus: "登录成功")
                //返回上一页
//                dismiss(animated: true, completion: nil)
                
            }
        }
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    
    
}
