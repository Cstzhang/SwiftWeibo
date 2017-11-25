//
//  ZBEmoticonManager.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/24.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
//表情管理器
class ZBEmoticonManager {
    //表情管理器单例
    static let shared = ZBEmoticonManager()
    lazy var packages = [ZBEmoticonPackage]()
    //构造函数 在init之前增加 private修饰符,可以要求调用者必须用shared访问对象
    //oc 中要重写 allocWithZone
    private init() {
        loadPackages()
    }
    
}
//MARK: -表情符号/字符串处理
extension ZBEmoticonManager{
    /// 将给定的字符串转换成属性文本
    ///
    /// - Parameter string: 字符串
    /// - Returns: 属性文本
    func emoticonString(string:String,font:UIFont) -> NSAttributedString {
        print(string)
        let attrString  = NSMutableAttributedString(string: string)
        //简历正则表达式，过滤所有的·表情·文字 [] ()都是正则的关键字，要参与匹配要转译
        let pattern = "\\[.*?\\]"
        guard let regx  = try? NSRegularExpression(pattern: pattern, options: []) else{
            return attrString
        }
        //匹配所有项
        let matches = regx.matches(in: string, options: [], range: NSRange(location: 0, length: attrString.length))
        //遍历
        for m in matches.reversed() {
            let r = m.range(at: 0)
            let subStr = ( attrString.string as NSString).substring(with: r)
            //对应的表情符号
            if let em  = ZBEmoticonManager.shared.findEmoticon(string: subStr){
                //FIXME: -需要字体 使用表情文本属性进行替换
                attrString.replaceCharacters(in: r, with: em.imageText(font:font))
            }
        }
        //统一设置一遍字符串的属性
        attrString.addAttributes([NSAttributedStringKey.font : font], range: NSRange(location: 0, length: attrString.length))
        return attrString
    }
    
    
    /// 根据string查找对应的表情模型对象
    ///
    /// - Parameter string: 表情string
    /// - Returns: 返回表情模型/nil
    func findEmoticon(string:String) -> ZBEmoticon? {
        for p in packages {
            //过滤string（1）
//            let result =  p.emoticons.filter({ (em) -> Bool in
//                return em.chs == string
//            })
             //过滤string（2）尾随闭包
//            let result =  p.emoticons.filter(){ (em) -> Bool in
//                return em.chs == string
//            }
             //过滤string（3）尾随闭包 （闭包中只有一句 且是返回，闭包格式定义可以省略，参数省略后使用 $0,$1一次替代原有参数 return也可以省略）
//            let result =  p.emoticons.filter() {
//                return $0.chs == string
//            }
            
            //过滤string（4）尾随闭包 （闭包中只有一句 且是返回，闭包格式定义可以省略，参数省略后使用 $0,$1一次替代原有参数 return也可以省略）
            let result =  p.emoticons.filter() { $0.chs == string }
            //返回找到的表情模型
            if result.count == 1{
                return result[0]
            }
        }
        return nil
    }
    
    
    
}


//表情包数据处理
private extension ZBEmoticonManager{
    func loadPackages() -> () {
        //数据路径 按照Bundle默认的路径的目录读取，就能获取到Resource目录下文件
        guard let path  = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
              let bundle  = Bundle(path: path),
              let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
              let array = NSArray(contentsOfFile: plistPath) as? [[String:String]],
              let models = NSArray.yy_modelArray(with: ZBEmoticonPackage.self, json: array) as? [ZBEmoticonPackage]
              else{
              return
        }
        //设置表情包数据 +=不会覆盖之前的懒加载的空间，直接追加数据
        packages += models
       
        print(packages)
        
    }

}
