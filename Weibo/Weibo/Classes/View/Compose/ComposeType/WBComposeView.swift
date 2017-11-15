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
    override init(frame: CGRect) {
        //设置frame
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.cz_random()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
}
