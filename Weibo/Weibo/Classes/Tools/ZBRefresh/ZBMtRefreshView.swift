//
//  ZBMtRefreshView.swift
//  Weibo
//
//  Created by zhangzb on 2017/11/13.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class ZBMtRefreshView: ZBRefreshView {

    @IBOutlet weak var buildingIconView: UIImageView!
    
    @IBOutlet weak var earthIconView: UIImageView!
    
    @IBOutlet weak var kangarooIconView: UIImageView!
    
    /// 动画
    override func awakeFromNib() {
        //房子
        let buildImage1 = #imageLiteral(resourceName: "icon_building_loading_1")
        let buildImage2 = #imageLiteral(resourceName: "icon_building_loading_2")
        buildingIconView.image = UIImage.animatedImage(with: [buildImage1,buildImage2], duration: 0.5)
        //地球
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = -2 * Double.pi //负数是逆时针
        animation.repeatCount = MAXFLOAT
        animation.duration = 3
        animation.isRemovedOnCompletion = false
        earthIconView.layer.add(animation, forKey: nil)
        //袋鼠
        
        
        
    }
    
    
    
}
