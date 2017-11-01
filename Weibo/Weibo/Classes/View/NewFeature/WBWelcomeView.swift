//
//  WBWelcomeView.swift
//  Weibo
//
//  Created by zhangzb on 2017/11/1.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class WBWelcomeView: UIView {
    //头像
    @IBOutlet weak var iconView: UIImageView!
    //头像的底部约束
    @IBOutlet weak var BottomCons: NSLayoutConstraint!
    //昵称 透明度默认为0 动画完成显示后修改
    @IBOutlet weak var TipLabel: UILabel!
    
    class func welcomeView()-> WBWelcomeView{
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        let v = nib.instantiate(withOwner: nib, options: nil)[0] as! WBWelcomeView
        //从xib 加载的视图默认600 * 600
        v.frame = UIScreen.main.bounds
        return v
    }
    //自动布局系统完成约束后,自动调用方法
//    override func layoutSubviews() {
//
//    }
    
    //视图被添加到window 上 视图已经显示
    override func didMoveToWindow() {
        super.didMoveToWindow()
        //视图是使用自动布局来设置的，只是设置了约束
        //当视图被添加到窗口，根据父视图的大小，计算约束值，更新控件位置
        //layoutIfNeeded 会根据当前的约束更新空间位置
        // - layoutIfNeeded执行后 会更具xib中的约束更新所有控件位置
        self.layoutIfNeeded()
        //头像上移动画
        BottomCons.constant = bounds.size.height - 200
        //动画
        UIView.animate(withDuration: 1.0,//执行时间
                       delay: 0,//延迟
                       usingSpringWithDamping: 0.7,//弹力系数
                       initialSpringVelocity: 0,//初试速度
                       options: [],
                       animations: {
                        //更新约束
                        self.layoutIfNeeded()
                        
        }) { (_) in//动画完成
            
        }
        
        
        
        
    }
    
    
 

}
