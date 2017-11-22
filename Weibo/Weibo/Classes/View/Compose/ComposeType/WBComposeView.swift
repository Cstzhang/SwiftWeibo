//
//  WBComposeView.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/                                    11/15.

//

import UIKit
import pop
//撰写微博类型视图
class WBComposeView: UIView {
    //选择类型view
    @IBOutlet weak var scrollView: UIScrollView!
    //关闭按钮
    @IBOutlet weak var closeButton: UIButton!
    //关闭按钮centerx
    @IBOutlet weak var closeButtonCenterX: NSLayoutConstraint!
    //返回按钮centerx
    @IBOutlet weak var returnButtonCenterX: NSLayoutConstraint!
    //返回按钮
    @IBOutlet weak var returnButton: UIButton!
    
    /// 按钮数据数组
    private let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "WBComposeViewController"],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                               ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                               ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                               ["imageName": "tabbar_compose_music", "title": "音乐"],
                               ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
    ]

    //构造函数
    class func WBComposeView()->WBComposeView{
        let nib = UINib(nibName: "WBComposeView", bundle: nil)
        //从xib加载完成就会调用awakefromnib
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeView
        // xib 加载默认是600*600
        v.frame = UIScreen.main.bounds
        
        v.setupUI()
        
        return v
    }

    /// 显示当前视图
    func show()  {
        //1 当前视图添加到显示视图 rootViewController是tabbarcontroller
        guard  let vc = UIApplication.shared.keyWindow?.rootViewController else{
            return
        }
        vc.view.addSubview(self)
        //2 设置虚化虚化效果
        showCurrentView()
        
    }
    @objc private func clickMore(){
        print("点击更多")
        //便宜view
        let offset = CGPoint(x: scrollView.bounds.width, y: 0)
        scrollView.setContentOffset(offset, animated: true)
        //处理底部按钮
        self.returnButton.isHidden = false
        let margin  =  scrollView.bounds.width/6
        closeButtonCenterX.constant += margin
        returnButtonCenterX.constant -= margin
        UIView.animate(withDuration: 0.25) {
            
            self.layoutIfNeeded()
        }
    }

    
    
    //MARK: -监听方法
    //点击类型按钮
    @objc private func clickButtn(btn:WBComposeTypeButton){
     print("点了\(btn.clsName ?? "")")
        
    }

    @IBAction func close() {
        print("关闭选择视图")
        hideButtons()
    }
    
    
    @IBAction func clickReturn() {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        closeButtonCenterX.constant = 0
        returnButtonCenterX.constant = 0
        print("点击返回")
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
            self.returnButton.alpha = 0
        }) { (_) in
            self.returnButton.isHidden = true
            self.returnButton.alpha = 1
        }
        
    }
    
    
    
}

private extension WBComposeView{
    // MARK: -显示动画
    //显示当前视图(透明度变化)
   private func showCurrentView(){
        //创建动画
    let animation:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.25
        //添加到视图
        pop_add(animation, forKey: nil)
        //添加按钮动画
        showButtons()
    }
    //弹力显示所有按钮
   private func showButtons() {
        //获取scrollview 的子视图的第0个视图
        let v = scrollView.subviews[0]
        //遍历V中所有button
        for (i,btn) in v.subviews.enumerated() {
            //创建动画
            let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            //动画属性
            anim.fromValue = btn.center.y + 350
            anim.toValue = btn.center.y
            //弹力系数
            anim.springBounciness = 8
            anim.springSpeed  = 8
            //动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            //添加动画
            btn.layer.pop_add(anim, forKey: nil)
        }
    }
    // MARK: -隐藏动画
    //隐藏按钮
    private func hideButtons(){
        //判断当前显示的子视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        //遍历所有按钮
        for (i,btn) in v.subviews.enumerated().reversed() {
            //创建动画
            let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            //动画属性
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 350
            anim.beginTime = CACurrentMediaTime()  + CFTimeInterval(v.subviews.count - i) * 0.025
            //添加动画
            btn.layer.pop_add(anim, forKey: nil)
            //监听最后一个执行的动画
            if i == 0 {
                anim.completionBlock = {(_,_)->() in
                    //隐藏当前视图
                    self.hideCurrentView()
                }
            }
        }
       
 
    }
    //隐藏当前视图
    private func hideCurrentView(){
        let anim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25
        pop_add(anim, forKey: nil)
        anim.completionBlock = {(_,_)->() in
            //隐藏当前视图
            self.removeFromSuperview()
        }

    }
    
    
}


// private 让extension中所有函数都是private
private extension WBComposeView{
    func setupUI()  {
        // 0 强行更新布局
        layoutIfNeeded()
        // 1 添加视图
        let rect = scrollView.bounds
        let width = scrollView.bounds.width
        
        for i in 0..<2 { //分2个批，生成View
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            addButton(v: v, index: i * 6)
            scrollView.addSubview(v)
        }
       scrollView.contentSize = CGSize(width: width * 2, height: scrollView.bounds.height)
       scrollView.showsVerticalScrollIndicator = false
       scrollView.showsHorizontalScrollIndicator = false
       scrollView.bounces = false
    }

    /// 循环添加类型按钮
    ///
    /// - Parameters:
    ///   - v: 主视图
    ///   - index: 索引
    func addButton(v:UIView,index:Int)  {
        //添加按钮
        let count = 6 //最多6个按钮
        for i in index ..< (index+count) {
            //1获取图形信息
            if i >= buttonsInfo.count{
                break
            }
            let dict = buttonsInfo[i]
            guard let imageName = dict["imageName"],
                   let title = dict["title"] else {
                continue
            }
            //创建按钮
            let btn = WBComposeTypeButton.composeTypeButton(image: imageName, title: title)
            //添加监听方法
            if let actionName = dict["actionName"]{
                //oc中使用NSSelctorFromSTRING(@"actionName")
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }else{
               
                btn.addTarget(self, action: #selector(clickButtn(btn:)), for: .touchUpInside)
                
            }
            //展现控制器
            btn.clsName = dict["clsName"]
            //添加到视图
            v.addSubview(btn)
            
        }
        //遍历视图的字数图 枚举 布局按钮
        //准备常量
        let btnSize = CGSize(width: 100, height: 100)
        let margin:CGFloat = (v.bounds.width - 3 * btnSize.width) / 4
        //循环布局
        for (i,btn) in v.subviews.enumerated() {
            let y:CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0 // 第二排的
            let colum = i % 3 //列
            let x = CGFloat(colum + 1) * margin + CGFloat(colum) * btnSize.width
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }

    }
    
}

