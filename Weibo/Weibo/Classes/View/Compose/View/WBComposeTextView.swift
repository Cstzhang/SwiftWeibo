//
//  WBComposeTextView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/29.
//  Copyright © 2017年 zhangzb. All rights reserved.
//
/*
 通知和代理的比对:
 通知：一对多，只要注册的监听者，在注销监听前，都可以接收到通知
 代理：一对一，最后设置的代理对象有效
 平常开发中多用到代理
- 代理是事件发生后，直接让代理执行协议方法
 代理的效率更高
 直接的反向传值
- 通知是发生事件时，将通知发送给通知中心，通知中心再进行广播
  通知的效率低一些
  如果嵌套的层数非常深，可以使用通知传值
 
 */

import UIKit
//撰写微博的文本视图
class WBComposeTextView: UITextView {
    private lazy var placeholderlabel = UILabel()
    override func awakeFromNib() {
        setupUI()
    }
    //监听输入
    @objc private func textChanged(n:Notification){
        //有文本不显示标签
        placeholderlabel.isHidden = self.hasText
    }
    //注销通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension WBComposeTextView:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        print("text")
    }
}

private extension WBComposeTextView{
    func setupUI(){
        //注册通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textChanged(n:)),
            name: NSNotification.Name.UITextViewTextDidChange,
            object: self)
        //1 设置占位标签
        placeholderlabel.text = "分享新鲜事..."
        placeholderlabel.font = self.font
        placeholderlabel.textColor = UIColor.lightGray
        placeholderlabel.frame.origin = CGPoint(x: 5, y: 8)
        placeholderlabel.sizeToFit()
        addSubview(placeholderlabel)
        self.delegate = self
    }
    
    
}
