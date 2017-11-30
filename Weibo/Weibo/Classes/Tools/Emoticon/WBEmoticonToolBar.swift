//
//  WBEmoticonToolBar.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/30.
//  Copyright © 2017年 zhangzb. All rights reserved.
//  表情键盘底部工具栏

import UIKit

class WBEmoticonToolBar: UIView {
    override func awakeFromNib() {
        setupUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let count  = subviews.count
        let w  = bounds.width / CGFloat(count)
        let rect  = CGRect(x: 0, y: 0, width: w, height: bounds.height)
        for (i ,btn ) in subviews.enumerated() {
            btn.frame = rect.offsetBy(dx: CGFloat(i) * w, dy: 0)
        }
    }

}

private extension WBEmoticonToolBar{
    
    func setupUI() -> () {
      //设置按钮（读取表情包分组名称）
      //0 获取表情管理器单例
        let manager  = ZBEmoticonManager.shared
      //1 获取分组名称 设置按钮
        for p  in manager.packages {
            let btn  = UIButton()
            btn.setTitle(p.groupName, for: [])
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.white, for: [])
            btn.setTitleColor(UIColor.darkGray, for: .highlighted)
            btn.setTitleColor(UIColor.darkGray, for: .selected)
            let imageName   = "compose_emotion_table_\(p.bgImageName ?? "")_normal"
            let imageNameHL = "compose_emotion_table_\(p.bgImageName ?? "")_selected"
            var  image = UIImage(named: imageName, in: manager.bundle, compatibleWith: nil)
            let size  = image?.size ?? CGSize()
            image = image?.resizableImage(withCapInsets: UIEdgeInsets(
                top: size.height * 0.5 ,
                left: size.width * 0.5,
                bottom: size.height * 0.5,
                right: size.width * 0.5))
  
            var imageHL = UIImage(named: imageNameHL, in: manager.bundle, compatibleWith: nil)
            imageHL = imageHL?.resizableImage(withCapInsets: UIEdgeInsets(
                top: size.height * 0.5 ,
                left: size.width * 0.5,
                bottom: size.height * 0.5,
                right: size.width * 0.5))
            btn.setBackgroundImage(image, for: [])
            btn.setBackgroundImage(imageHL, for: .highlighted)
            btn.setBackgroundImage(imageHL, for: .selected)
            // 3 添加按钮
            btn.sizeToFit()
            addSubview(btn)
        }
        
        
        
        
        
        
        
        
        
    }
    
}
