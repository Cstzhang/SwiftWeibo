//
//  WBNewFeatureView.swift
//  Weibo
//
//  Created by zhangzb on 2017/11/1.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    //进入微博
    @IBAction func enterStatus() {
        removeFromSuperview()
    }
    class func newFeatureView()-> WBNewFeatureView{
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nib, options: nil)[0] as! WBNewFeatureView
        //从xib 加载的视图默认600 * 600
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        //如果使用自动布局设置的界面，从xib 加载默认是600*600 大小
//        print(bounds)
        //添加4个图形视图
        let count  = 4
        let rect = UIScreen.main.bounds
        
        for i in 0..<count {
            let imageName = "new_feature_\(i + 1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            //设置大小  //水平偏移 垂直方向不用偏移
            iv.frame  = rect.offsetBy(dx: CGFloat(i)*rect.width , dy: 0)
            scrollView.addSubview(iv)
            
        }
        // scrollView
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        //隐藏按钮
        enterButton.isHidden = true
        
        
    }
    
    
}

extension WBNewFeatureView:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //1 滚动到最后1屏的时候，让视图移除
        let page  = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        //2 判断是否最后一页
        if page == scrollView.subviews.count {
            //让视图移除
            removeFromSuperview()
        }
        
        // 倒数第二页，显示按钮
         enterButton.isHidden =  (page != scrollView.subviews.count - 1)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 一旦滚动隐藏按钮
        enterButton.isHidden = true
        //计算偏移量
        let page  = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        //显示页码
        pageControl.currentPage = page
        
        pageControl.isHidden = (page  == scrollView.subviews.count)
        
    }
    
    
    
}
