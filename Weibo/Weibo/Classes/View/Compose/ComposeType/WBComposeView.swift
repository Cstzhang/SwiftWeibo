//
//  WBComposeView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/                                    11/15.

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
        let rect = scrollView.bounds
        let v = UIView(frame: rect)
        addButton(v: v, index: 0)
        scrollView.addSubview(v)
    }

    /// 循环添加类型按钮
    ///
    /// - Parameters:
    ///   - v: 主视图
    ///   - index: 索引
    func addButton(v:UIView,index:Int)  {
        //添加按钮
        let count = 6
        for i in index ..< (index+count) {
            //1获取图形信息
            if index >= buttonsInfo.count{
                return
            }
            let dict = buttonsInfo[i]
            guard let imageName = dict["imageName"],
                   let title = dict["title"] else {
                continue
            }
            
            let btn = WBComposeTypeButton.composeTypeButton(image: imageName, title: title)
            v.addSubview(btn)
        }
        //遍历视图的字数图 枚举 布局按钮
        //准备常量
        let btnSize = CGSize(width: 100, height: 100)
        let margin:CGFloat = (v.bounds.width - 3 * btnSize.width) / 4
 
        for (i,btn) in v.subviews.enumerated() {
            let y:CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            let colum = i % 3 //列
            let x = CGFloat(colum + 1) * margin + CGFloat(colum) * btnSize.width
            
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
            
            
        }
        
        
        
    }
    
}

