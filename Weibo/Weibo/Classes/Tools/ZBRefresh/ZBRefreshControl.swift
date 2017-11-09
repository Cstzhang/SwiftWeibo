//
//  ZBRefreshControl.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/9.
//  Copyright © 2017年 zhangzb. All rights reserved.
//
//  刷新控件
import UIKit

class ZBRefreshControl: UIControl {
   //MARK 刷新控件父视图  应该支持 UItableView  UICollectionView
    private weak var scrollView:UIScrollView?
    
    init() {
        super.init(frame: CGRect())
                setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                setupUI()
        
    }
    /*
     newSuperview: addSubview回调用
     1,添加到父视图时newSuperview 是父视图
     2,父视图为空newSuperview = nil
     */
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        //判断父视图的类型
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        //记录父视图
        scrollView = sv
        
        //KVO监听父视图的contentOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
        
    }
    //本视图从父视图上移除
    override func removeFromSuperview() {
        //superview 还存在
        //移除KVO监听
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        super.removeFromSuperview()
       //superview 不存在
    }
    
    
    //kvo方法回调
    /*
     观察者模式有2中 通知中心 KVO
     通知中心不释放，内存泄露，重复注册
     KVO不释放，崩溃
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //刷新控件的高度初始化高度
        guard let sv = scrollView else {
            return
        }
        //contentOffset的y值和contentInset 的top有关
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        
        //根据高度 刷新控件的frame
        self.frame = CGRect(x: 0,
                            y: -height,
                            width: sv.bounds.width,
                            height: height)
    }
    
    
    //开始刷新
    func beginRefreshing(){
        print("开始刷新")

    }
    //结束刷新
    func endRefreshing(){
        print("结束刷新")
     
    }

}

extension ZBRefreshControl{
    
    private func setupUI(){
        self.backgroundColor = UIColor.red
        
    }
    
    
}












