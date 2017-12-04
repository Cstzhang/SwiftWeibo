//
//  WBEmoticonToolBar.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/30.
//  Copyright © 2017年 zhangzb. All rights reserved.
//  表情键盘底部工具栏

import UIKit
@objc protocol WBEmoticonToolBarDelegate:NSObjectProtocol{
    
    /// 表情分组索引
    ///
    /// - Parameters:
    ///   - toolBar: 工具栏
    ///   - index: 索引
    func emoticonToolBarDidSelectedItemIndex(toolBar:WBEmoticonToolBar,index:Int)
}

class WBEmoticonToolBar: UIView {
    
    /// 代理
    weak var delegate:WBEmoticonToolBarDelegate?
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
    
    //MARK: -监听方法
    @objc private func clickItem(button:UIButton){
        delegate?.emoticonToolBarDidSelectedItemIndex(toolBar: self, index: button.tag)
    }

}

private extension WBEmoticonToolBar{
    
    func setupUI() -> () {
      //设置按钮（读取表情包分组名称）
      //0 获取表情管理器单例
        let manager  = ZBEmoticonManager.shared
      //1 获取分组名称 设置按钮
        for (i,p)  in manager.packages.enumerated() {
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
            // 4 设置按钮
            btn.tag = i
            // 5 添加监听方法
            btn.addTarget(self, action: #selector(clickItem(button:)), for: .touchUpInside)
        }
        //默认选中第0个按钮
        (subviews[0] as! UIButton).isSelected = true
        
    }
    
}
