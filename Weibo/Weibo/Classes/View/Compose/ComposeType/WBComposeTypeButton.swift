//
//  WBComposeTypeButton.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/15.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class WBComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    //要展示的控制器的类名
    var clsName:String?
    
    /// 创建一个类型按钮
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - title: 文字
    /// - Returns: 按钮view
    class func composeTypeButton(image:String,title:String)->WBComposeTypeButton {
        let nib = UINib(nibName: "WBComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeButton
        btn.imageView.image = UIImage(named: image)
        btn.titleLabel.text = title
        return btn
    }
    
    
    
    
    
}
