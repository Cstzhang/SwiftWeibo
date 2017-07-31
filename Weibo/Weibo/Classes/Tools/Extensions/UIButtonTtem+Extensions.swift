//
//  UIButtonTtem+Extensions.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/31.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /// 创建 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize 默认16
    ///   - target: target
    ///   - action: action
    convenience init(title:String,fontSize:CGFloat = 16,target:AnyObject?,action:Selector){
        let btn:UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
    //添加点击事件
    btn.addTarget(target, action: action, for: .touchUpInside)
        
      //实例化 UIBarButtonItem
        self.init(customView:btn)
    }
    


}
