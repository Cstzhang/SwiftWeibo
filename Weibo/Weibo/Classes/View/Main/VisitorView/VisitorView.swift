//
//  VisitorView.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/31.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

//访客视图
class VisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   // MARK: - 私有控件
    //圈视图
    fileprivate lazy var iconView:UIImageView = UIImageView(image: UIImage.init(named: "visitordiscover_feed_image_smallicon"))
    //房子
    fileprivate lazy var houseIconView:UIImageView = UIImageView(image: UIImage.init(named: "visitordiscover_feed_image_house"))
    //提示语
    fileprivate lazy var tipLabel:UILabel = UILabel.cz_label(withText: "关注一些人,回这里看看有什么惊喜",
                                                      fontSize: 14,
                                                      color: UIColor.darkGray)
    //注册按钮
    fileprivate lazy var registerButton:UIButton = UIButton.cz_textButton(
        "注册",
        fontSize: 16,
        normalColor: UIColor.orange,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")
    //登录按钮
    fileprivate lazy var loginButton:UIButton = UIButton.cz_textButton(
        "登录",
        fontSize: 16,
        normalColor: UIColor.darkGray,
        highlightedColor: UIColor.black,
        backgroundImageName: "common_button_white_disable")
    
}

extension VisitorView{
    func setupUI()  {
        backgroundColor = UIColor.white
        addSubview(iconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        //取消 autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        //自动布局
        //圆圈背景图视图
        addConstraint(NSLayoutConstraint(item: iconView,
                                       attribute: .centerX,
                                       relatedBy: .equal,
                                       toItem: self,
                                       attribute: .centerX,
                                       multiplier: 1.0,
                                       constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
    
        //房子
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        
        
        
        
        
        
        
        
        
    }
    


}
