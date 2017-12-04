//
//  ZBEmoticonTipView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/12/4.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import pop
//表情选择提示视图 emoticon_keyboard_magnifier@2x
class ZBEmoticonTipView: UIImageView {
    private var preEmoticon:ZBEmoticon?
    var emoticon:ZBEmoticon?{
        didSet{
            if emoticon == preEmoticon {
                return
            }
            //记录当前表情
            preEmoticon = emoticon
            tipButton.setTitle(emoticon?.emoji, for: [])
            tipButton.setImage(emoticon?.image, for: [])
            //动画 - 弹力动画的结束时间不能指定duration
            let animation:POPSpringAnimation   = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            animation.fromValue = 30
            animation.toValue = 8
            animation.springBounciness = 20
            animation.springSpeed = 20
            tipButton.layer.pop_add(animation, forKey: nil)
            
        }
    }
    
    //MARK: -私有控件
    private lazy var tipButton = UIButton()
    //MARK: -构造函数
    init() {
        let bundle  = ZBEmoticonManager.shared.bundle
        let image  = UIImage(named: "emoticon_keyboard_magnifier", in: bundle, compatibleWith: nil)
        //会根据图像的按大小设置图像视图的大小
        super.init(image: image)
        //设置锚点
        layer.anchorPoint = CGPoint(x: 0.5, y: 1.2)
        //添加按钮
        tipButton.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        tipButton.frame = CGRect(x: 0, y: 8, width: 36, height: 36)
        tipButton.center.x = bounds.width * 0.5
        tipButton.setTitle("😆", for: [])
        tipButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        addSubview(tipButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
