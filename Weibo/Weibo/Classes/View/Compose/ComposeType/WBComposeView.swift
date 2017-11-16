//
//  WBComposeView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/15.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
//撰写微博类型视图
class WBComposeView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    /// 按钮数据数组
    private let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "WBComposeViewController"],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                               ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                               ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                               ["imageName": "tabbar_compose_music", "title": "音乐"],
                               ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
    ]

    //构造函数
    class func WBComposeView()->WBComposeView{
        let nib = UINib(nibName: "WBComposeView", bundle: nil)
        //从xib加载完成就会调用awakefromnib
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeView
        // xib 加载默认是600*600
        v.frame = UIScreen.main.bounds
        
        v.setupUI()
        
        return v
    }

    /// 显示当前视图
    func show()  {
        //1 当前视图添加到显示视图 rootViewController是tabbarcontroller
        guard  let vc = UIApplication.shared.keyWindow?.rootViewController else{
            return
        }
        vc.view.addSubview(self)
        //2 设置虚化虚化效果
        
        
    }
    

    
    //点击类型按钮
    @objc private func clickButtn(){
     print("test ===== test")
    }
    
    @IBAction func close() {
        print("关闭选择视图")
        removeFromSuperview()
    }
    
}

// private 让extension中所有函数都是private
private extension WBComposeView{
    func setupUI()  {
        // 0 强行更新布局
        layoutIfNeeded()
        // 1 添加视图
        let v = UIView()
        
        
    }
    
    
}

