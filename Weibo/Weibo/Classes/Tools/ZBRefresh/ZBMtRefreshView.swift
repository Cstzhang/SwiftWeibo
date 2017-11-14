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
    //父视图的高度
    override var parentViewHeight:CGFloat{
        didSet{
            if parentViewHeight < 23 {
                return
            }
            //高度差/最大高度差
            // 23  == 1 -> 0.2
            // 126 == 0 -> 1
            var scale:CGFloat
            
            if parentViewHeight > 126 {
                scale = 1
            }else{
                scale = 1 - ((126 - parentViewHeight) / (126 - 23))
                
            }
          
            kangarooIconView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            
        }
        
    }
    
    
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
        //0 袋鼠动画
        let kImage1 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_1")
        let kInage2 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_2")
        kangarooIconView.image = UIImage.animatedImage(with: [kImage1,kInage2], duration: 0.5)
        //1 锚点
        kangarooIconView.layer.anchorPoint =  CGPoint(x: 0.5, y: 1)
        //2 设置frame/center
        kangarooIconView.center = CGPoint(x: (self.bounds.width * 0.5), y: (self.bounds.height-23))
        //3 缩小
        kangarooIconView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
       
        
        
    }
    
    
    
}
