//
//  ZBRefreshControl.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/9.
//  Copyright © 2017年 zhangzb. All rights reserved.
//
//  刷新控件 刷新相关逻辑
import UIKit

//刷新状态切换临界点
private let ZBRefreshOffset:CGFloat = 60

/// 刷新状态
///
/// - Normal: 普通状态，下拉中
/// - Pulling: 正在下拉且超过临界点，放手的话开始刷新
/// - WillRefresh: 超过下拉临界点，并放手，将要刷新的状态
enum ZBRefreshStatus{
    case Normal
    case Pulling
    case WillRefresh
    
}

class ZBRefreshControl: UIControl {
    //MARK 刷新控件父视图  应该支持 UItableView  UICollectionView
    private weak var scrollView:UIScrollView?
    //创建刷新视图
    private lazy var refreshView:ZBRefreshView = ZBRefreshView.refreshView()
    //
    
    
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
        if height < 0 {
            return
        }
        //根据高度 刷新控件的frame
        self.frame = CGRect(x: 0,
                            y: -height,
                            width: sv.bounds.width,
                            height: height)
        
        //拖拽状态 -临界点只需要判断一次
        if sv.isDragging{
            //判断是否到临界点  往下拉 且还没有变过一次状态
            if height > ZBRefreshOffset && (refreshView.refreshStatus == .Normal){
                //修改状态
                refreshView.refreshStatus = .Pulling
                
             //往回推
            }else if height <= ZBRefreshOffset && (refreshView.refreshStatus == .Pulling){
                 refreshView.refreshStatus = .Normal

            }
        }else{
            //放手 - 判断是否超过临界点
            if refreshView.refreshStatus == .Pulling{
               print("准备刷新")
               beginRefreshing()
               //发送刷新数据事件
               sendActions(for: .valueChanged)
            }
        }
        
    }
    
    
    //开始刷新
    func beginRefreshing(){
        print("开始刷新")
         //判断是否正在刷新，如果已经在刷新，直接返回
        if refreshView.refreshStatus == .WillRefresh {
           return
        }
        
        //判断父视图
        guard let sv = scrollView else{
            return
        }
        
        //设置刷新视图状态
        refreshView.refreshStatus = .WillRefresh
        
        //让整个刷新视图可以显示出来
        var inset = sv.contentInset
        inset.top += ZBRefreshOffset
        sv.contentInset = inset
        
        

    }
    
    //结束刷新
    func endRefreshing(){
        //判断是否正在刷新，如果不是刷新，直接返回
        if refreshView.refreshStatus != .WillRefresh {
            return
        }
        print("结束刷新")
        guard let sv = scrollView else{
            return
        }
        //隐藏菊花 回复刷新视图状态
        refreshView.refreshStatus = .Normal
        //回复表格视图的contentInset
        var inset = sv.contentInset
        inset.top -= ZBRefreshOffset
        sv.contentInset = inset
    }
    

}

extension ZBRefreshControl{
    
    private func setupUI(){
        self.backgroundColor = superview?.backgroundColor
        //设置超出边界不显示
        //clipsToBounds = true
        //添加刷新视图 - 从xib 中加载写出来 默认是xib 中制定的宽高
        addSubview(refreshView)
        //自动布局 设置xib的自动布局，需要制定宽高
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.width))
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))
        
    }
    
    
}












