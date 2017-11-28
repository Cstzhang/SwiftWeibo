//
//  WBWebViewController.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/27.
//  Copyright © 2017年 zhangzb. All rights reserved.
//  网页控制器

import UIKit

class WBWebViewController: BaseViewController {
    private lazy var webView = UIWebView(frame: UIScreen.main.bounds)
    var urlString:String?{
        didSet{
           guard  let urlString  = urlString,
                  let url = URL(string: urlString) else{
                return
            }
           webView.loadRequest(URLRequest(url: url))
        }
    }
}

extension WBWebViewController{
    override func setupTableView() {
        //标题
        navItem.title = "网页"
        //设置webView
        view.insertSubview(webView, belowSubview: navigationBar)
        webView.backgroundColor = UIColor.white
        //设置contentInset
        webView.scrollView.contentInset.top = navigationBar.bounds.height
    }
    
    
}
