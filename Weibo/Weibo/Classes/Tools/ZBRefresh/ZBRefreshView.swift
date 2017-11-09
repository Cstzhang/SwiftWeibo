//
//  ZBRefreshView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/9.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class ZBRefreshView: UIView {
    //初始化刷新状态
    var refreshStatus:ZBRefreshStatus = .Normal{
        didSet{
            switch refreshStatus {
            case .Normal:
                tipLabel.text = "继续使劲拉..."
                
            case .Pulling:
                 tipLabel.text = "放手就劲拉..."
                
                
            case .WillRefresh:
                 tipLabel.text = "正在刷新中..."
            
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

