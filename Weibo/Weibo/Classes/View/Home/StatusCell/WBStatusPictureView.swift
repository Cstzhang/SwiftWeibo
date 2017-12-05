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
            urls = viewModel?.picURLs
            
            calcViewSize()
            
        }
        
    }
    //根据图片大小 调整显示内容
    private func calcViewSize(){
    //宽度
      //1 单图,根据配图视图的大小修改subview[0]的宽高
        if viewModel?.picURLs?.count == 1 {
            let viewSize = viewModel?.pictureViewSize ?? CGSize()
            let v = subviews[0]
            v.frame =  CGRect(x: 0, y: WBStatusPictureOutterMargin, width: viewSize.width, height: viewSize.height - WBStatusPictureOutterMargin)
        }else{      //2 多图/无图，恢复subview[0]的宽高，保持九宫格的完整
            let v  = subviews[0]
            v.frame = CGRect(x: 0, y: WBStatusPictureOutterMargin, width: WBStatusPictureViewItemWidth, height: WBStatusPictureViewItemWidth)
        }
   
    //高度
    heightCons.constant = viewModel?.pictureViewSize.height ?? 0
    }
    
    //配图视图数组
    private var urls: [WBStatusPicture]?{
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
                //设置图像
                iv.zb_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                //判断是不是gif
                iv.subviews[0].isHidden = (((url.thumbnail_pic ?? "") as NSString).pathExtension.lowercased() != "gif")
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
    
    //图片点击手势监听
    /// @param selectedIndex    选中照片索引
    /// @param urls             浏览照片 URL 字符串数组
    /// @param parentImageViews 父视图的图像视图数组，用户展现和解除转场动画参照
    @objc private func tapImageView(tap:UITapGestureRecognizer){
        guard let iv  = tap.view,
              let picURLs = viewModel?.picURLs
        else{
            return
        }
        var selectedIndex = iv.tag
        //4 张图处理(特殊情况)
        if picURLs.count == 4 && selectedIndex>1{
           selectedIndex -= 1
        }
        let urls = (picURLs as NSArray).value(forKey: "largePic") as! [String]
          //处理可见的图像视图数组
        var imageViewList = [UIImageView]()
        for iv in subviews as! [UIImageView] {
            if !iv.isHidden{
                imageViewList.append(iv)
            }
        }
        //print(imageViewList)
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBStatusCellBrowserPhotoNotification),
                                        object: self,
                                        userInfo: [WBStatusCellBrowserPhotoURLKey:urls,
                                        WBStatusCellBrowserPhotoImageViewsKey:imageViewList,
                                        WBStatusCellBrowserPhotoSelectedIndexKey:selectedIndex
                                                   ])
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
            //让图片可以交互
            iv.isUserInteractionEnabled = true
            //添加手势识别
            let tap  = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
            iv.addGestureRecognizer(tap)
            //设置imageview tag
            iv.tag = i
            //添加动图标签
            
            addGifView(iv: iv)
            
            
            
        }
    }
    
    /// 图像中加一个GIF提示图像
    private func addGifView(iv:UIImageView){
        //添加一个GIF 标识图
        let gifImageView  = UIImageView(image: UIImage(named: "timeline_image_gif"))
        iv.addSubview(gifImageView)
        //自动布局
        
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        
        iv.addConstraint(NSLayoutConstraint(item: gifImageView,
                                            attribute: .right,
                                            relatedBy: .equal,
                                            toItem: iv,
                                            attribute: .right,
                                            multiplier: 1.0,
                                            constant: 0))
        iv.addConstraint(NSLayoutConstraint(item: gifImageView,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: iv,
                                            attribute: .bottom,
                                            multiplier: 1.0,
                                            constant: 0))
    }
    
    
    
}
