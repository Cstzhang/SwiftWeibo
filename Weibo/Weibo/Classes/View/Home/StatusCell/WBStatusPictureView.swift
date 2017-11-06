//
//  WBStatusPictureView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/3.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {

    @IBOutlet weak var  heightCons:NSLayoutConstraint!
    
    override func awakeFromNib() {
        setupUI()
    }
    
    

}

//设置界面
extension WBStatusPictureView{
    //1，cell中所有控件提前创建好
    //2，设置时依据数据判断是否显示
    //3，不要动态创建
    
    private func setupUI() -> () {
        //超出边界的部分不显示
        clipsToBounds = true
        //1，创建9个imageview
        let count = 3
        let rect = CGRect(x:0 , y: WBStatusPictureOutterMargin, width: WBStatusPictureViewItemWidth, height: WBStatusPictureViewItemWidth)
        
        for i in 0..<count * count {
            let iv = UIImageView()
            iv.backgroundColor = UIColor.red
            //行 - Y
            let row = CGFloat(i / count)
            
            
            //列 - X
            let col = CGFloat(i % count)
            
            iv.frame = rect.offsetBy(dx: col * (WBStatusPictureViewItemWidth + WBStatusPictureInnerMargin), dy: row *   (WBStatusPictureViewItemWidth + WBStatusPictureInnerMargin))
            
            addSubview(iv)
            
            
        }
        
        
        
        
    }
    
    
    
}
