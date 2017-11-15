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
    //构造函数
    class func WBComposeView()->WBComposeView{
        let nib = UINib(nibName: "WBComposeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeView
        // xib 加载默认是600*600
        v.frame = UIScreen.main.bounds
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
    
    override func awakeFromNib() {
        setupUI()
        print("test 11")
    }
    
    //点击类型按钮
    @objc private func clickButtn(){
     print("test ===== test")
    }
    
}

// private 让extension中所有函数都是private
private extension WBComposeView{
    func setupUI()  {
        let btn = WBComposeTypeButton.composeTypeButton(image: "tabbar_compose_music", title: "test")
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        addSubview(btn)
        btn.addTarget(self, action: #selector(clickButtn), for: .touchUpInside)
        
    }
    
    
}

