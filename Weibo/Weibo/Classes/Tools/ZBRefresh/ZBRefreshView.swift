//
//  ZBRefreshView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/9.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
//UIView 动画 系统默认顺时针旋转
//就近原则（哪条路径近就走哪条 - 0.001）
//想要360度旋转， 需要  CABaseAnimation

class ZBRefreshView: UIView {
    //初始化刷新状态
    var refreshStatus:ZBRefreshStatus = .Normal{
        didSet{
            switch refreshStatus {
            case .Normal:
                tipLabel.text =  "继续使劲拉..."
                UIView.animate(withDuration: 0.25, animations: {
                   self.tipIcon.transform = CGAffineTransform.identity
                })
                
            case .Pulling:
                tipLabel.text = "放手就刷新..."
                UIView.animate(withDuration: 0.25, animations: {
                    self.tipIcon.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi - 0.001))

                })
            case .WillRefresh:
                 tipLabel.text = "正在刷新中..."
                 //隐藏提示图标，显示菊花
                 tipIcon.isHidden = true
                 indicator.startAnimating()
            
            }
        }
        
    }
    //提示图标
    @IBOutlet weak var tipIcon: UIImageView!

    
    @IBOutlet weak var tipLabel: UILabel!
    

    //指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    class func refreshView()->ZBRefreshView{
        let nib = UINib(nibName: "ZBRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as!ZBRefreshView

    }
    
    
}

