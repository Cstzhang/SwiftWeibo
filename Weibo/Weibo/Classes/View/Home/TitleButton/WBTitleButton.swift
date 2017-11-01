//
//  WBTitleButton.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/31.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {
    //重载构造函数 新加一个
    //title=nil 显示首页 不为nil 显示title 和箭头图形
    init(title: String?) {
        super.init(frame: CGRect())
        //1 判断title是否为nil
        if title == nil {
            setTitle("首页", for: .normal)
        }else{
            setTitle(title! + " ", for: .normal)
            setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
            setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
        }
        //2 字体
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        //3 颜色
        setTitleColor(UIColor.darkGray, for: .normal)
        setTitleColor(UIColor.black, for: .selected)
        //4 设置大小
        sizeToFit()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //自定义UI 布局调整
    override func layoutSubviews() {
        super.layoutSubviews()//一定要有super
        guard let titleLabel = titleLabel,
              let imageView = imageView  else {
              return
        }
        //label的x向左移动image宽度 image的x向右移动label宽度
        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width, dy: 0)
    }
    

}
