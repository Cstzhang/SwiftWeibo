//
//  ZBRefreshView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/9.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class ZBRefreshView: UIView {
    
    //提示图标
    @IBOutlet weak var tipIcon: UIImageView!
    //提示文字
    @IBOutlet weak var tipLabel: UIImageView!
    //指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    class func refreshView()->ZBRefreshView{
        let nib = UINib(nibName: "ZBRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as!ZBRefreshView

    }
    
    
}

