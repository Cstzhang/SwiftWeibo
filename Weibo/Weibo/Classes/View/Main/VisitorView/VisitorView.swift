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
    //访客视图信息字典
    var visitorInfo : [String : String]?{
        didSet{
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                    return
            }
            tipLabel.text = message
            //设置视图，首页不需要设置，直接返回
            if imageName == "" {
                startAnimatio()
                return
            }
            iconView.image = UIImage(named: imageName)
            //其他控制器的视图不显示小房子
            houseIconView.isHidden = true
            maskIconView.isHidden = true
        }
    
    }
    
    // MARK: -构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //旋转图标动画
    private func startAnimatio(){
        //旋转
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * Double.pi
        animation.repeatCount = MAXFLOAT
        animation.duration = 15
        //动画完成不删除，如果iconView被释放，动画也被销毁
        animation.isRemovedOnCompletion = false
        //动画添加到图层
        iconView.layer.add(animation, forKey: nil)
        
        
        
        
    }
    
    
    
   // MARK: - 私有控件

    //圈视图
    fileprivate lazy var iconView:UIImageView = UIImageView(image: UIImage.init(named: "visitordiscover_feed_image_smallicon"))
    //背景图
    fileprivate lazy var maskIconView :UIImageView = UIImageView(image: UIImage.init(named: "visitordiscover_feed_mask_smallicon"))
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
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        //文本居中对齐
        tipLabel.textAlignment = .center
        
        //取消 autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        //自动布局
        let margin:CGFloat = 20.0
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
        //提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        //宽度
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute:.notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 240))
        //注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute:.left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute:.bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute:.notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        //登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute:.right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute:.bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: registerButton,
                                         attribute:.width,
                                         multiplier: 1.0,
                                         constant: 0))
        
        //遮罩视图  views是定义VEL中控件名称和实际名称的映射关系
        //metrics 定义VFL中（）指定的常数映射关系
        
        let viewDict = ["maskIconView":maskIconView,
                        "loginButton": loginButton] as [String : Any]
//        let metrics = ["spacing": 20]
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskIconView]-0-|",
            options: [],
            metrics: nil,
            views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-20-[loginButton]",
            options: [],
            metrics: nil,
            views: viewDict))
        
    
        
    }
    


}
