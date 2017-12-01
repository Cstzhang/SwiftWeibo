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
    @objc private func textChanged(){
        //有文本不显示标签
        placeholderlabel.isHidden = self.hasText
    }
    //注销通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: - 表情键盘方法
extension WBComposeTextView{
    //返回对应的表情文字混合文本（图片表情换成文字）
    var  emoticonText:String?{
        // 1 获取textView的属性文本
        guard let attrStr = attributedText else {
            return ""
        }
        
        //2 获取需要转换的图片 [Attachment]
        //准备用于返回的文本
        var result = String()
        // 1遍历范围
        // 2选项
        // 3闭包
        attrStr.enumerateAttributes(in: NSRange(location: 0, length: attrStr.length), options: [])
            { (dict, range, _) in
            //如果文本属性中含有 NSAttributedStringKey.attachment说明有图片，替换成文本，反之则是文字
            if let attachment  = dict[NSAttributedStringKey.attachment] as? ZBEmoticonAttachment{
                //整合
                result += attachment.chs ?? ""
            }else{
                //截取出来对应的文本
                let subStr  = (attrStr.string as NSString).substring(with: range)
                //整合
                result += subStr
                }
        }
        return result
    }
    
    
    
    //表情字符插入文本框[图文混排]
     func insertEmoticon(em:ZBEmoticon?) -> () {
        //删除按钮
        if em == nil  {//em为空，是删除按钮
            deleteBackward()
            return
        }
        //表情emoji
        if let emoji = em?.emoji, let textRange = self.selectedTextRange{
            replace(textRange, withText: emoji)
            return
        }
        //图片处理
        // 0 图片 （所有的排版系统中，插入一个字符的显示，跟随前面一个字符的属性，本身没有属性）
        let imageText = em?.imageText(font: font!)
        
        //设置图像文字的属性
        // 1 获取当前textView属性文本 =>可变
        let attrM = NSMutableAttributedString(attributedString: attributedText)
        // 2 图像的属性文本出入到当前的光标位置
        attrM.replaceCharacters(in: selectedRange, with: imageText!)
        //  记录光标位置
        let range  = selectedRange
        // 3 重新设置属性文本
        attributedText = attrM
        // 恢复光标位置 length 是选中字符的长度，插入文本后应该为哦
        selectedRange = NSRange(location: range.location + 1, length: 0)
        // 4 让代理执行文本变化方法 - 在需要的时候通知代理执行协议方法
        delegate?.textViewDidChange?(self)
        // 文本变化
        textChanged()
    }
    
    
}

private extension WBComposeTextView{
    func setupUI(){
        //注册通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textChanged),
            name: NSNotification.Name.UITextViewTextDidChange,
            object: self)
        //1 设置占位标签
        placeholderlabel.text = "分享新鲜事..."
        placeholderlabel.font = self.font
        placeholderlabel.textColor = UIColor.lightGray
        placeholderlabel.frame.origin = CGPoint(x: 5, y: 8)
        placeholderlabel.sizeToFit()
        addSubview(placeholderlabel)
//        self.delegate = self
    }
    
    
    
}
