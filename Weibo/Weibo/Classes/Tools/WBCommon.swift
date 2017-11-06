//
//  WBCommon.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/30.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
//登录通知
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"

let WBUserLoginSuccessNotification = "WBUserLoginSuccessNotification"
//程序ID
let WBAppKey = "3600261914"
//加密信息
let WBAppSecret =  "136f1a5e9daddf4324b6fda287e4f29b"
//回调地址（登录完成跳转 ）
//http://www.jianshu.com/u/f07c03e14755?code=fee07bfbabc31fa344481871c200fac0
let WBRedirectURL = "http://www.jianshu.com/u/f07c03e14755"

//MARK: 微博视图常量
//1，配图视图的宽度
//视图外侧间距
let WBStatusPictureOutterMargin:CGFloat = 12
//视图内部视图间距
let WBStatusPictureInnerMargin:CGFloat = 3
//配图视图宽度
let WBStatusPictureViewWidth = UIScreen.cz_screenWidth() - 2 * WBStatusPictureOutterMargin
//2,高度
//每个Items的宽度
let  WBStatusPictureViewItemWidth = (WBStatusPictureViewWidth - 2*WBStatusPictureInnerMargin) / 3
