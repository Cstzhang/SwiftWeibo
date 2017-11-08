//
//  WBStatusPictureView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/3.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {
    
    var viewModel:WBStatusViewModel?{
        didSet{
            calcViewSize()
        }
        
    }
    //根据图片大小 调整显示内容
    private func calcViewSize(){
        //高度
        heightCons.constant = viewModel?.pictureViewSize.height ?? 0
    }
    
    //配图视图数组
    var urls: [WBStatusPicture]?{
        didSet{
            //1隐藏所有imageView
            for v in subviews {
                v.isHidden = true
            }
            //2遍历urls数组，设置图形
            var index = 0
            for url in urls ?? [] {
                
                let iv  = subviews[index] as! UIImageView
                
                //四张图处理 跳过第三张 换到下一行
                if index == 1 && urls?.count == 4{
                    index += 1
                }
                
                iv.zb_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                //显示图
                 iv.isHidden = false
                
                index += 1
            }
            
            
        }
        
    }
    
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
        //设置背景颜色
        backgroundColor = superview?.backgroundColor
        //超出边界的部分不显示
        clipsToBounds = true
        //1，创建9个imageview
        let count = 3
        let rect = CGRect(x:0 , y: WBStatusPictureOutterMargin, width: WBStatusPictureViewItemWidth, height: WBStatusPictureViewItemWidth)
        
        for i in 0..<count * count {
            let iv = UIImageView()
            
            //图形填充
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            
            //行 - Y
            let row = CGFloat(i / count)
            //列 - X
            let col = CGFloat(i % count)
            
            iv.frame = rect.offsetBy(dx: col * (WBStatusPictureViewItemWidth + WBStatusPictureInnerMargin), dy: row *   (WBStatusPictureViewItemWidth + WBStatusPictureInnerMargin))
            
            addSubview(iv)
            
            
        }
        
        
        
        
    }
    
    
    
}
