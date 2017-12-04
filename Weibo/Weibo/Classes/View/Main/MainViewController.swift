//
//  MainViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//  private当前类当前代码块访问 fileprivate当前文件内访问 @objc 允许函数在“运行时”通过OC的消息机制 被调用

import UIKit
import SVProgressHUD
class MainViewController: UITabBarController {
    //定时器
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildController()
        setupComposeButton()
        setupTimer()
        //设置新特效视图
        setupNewFeature()
        //设置tabbar 代理
        delegate = self
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userlogin), name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    
    //销毁
    deinit {
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)

    }
    
    //修改横竖设置 portrait 竖屏 landscape 横屏 在需要横屏的时候单独处理
    //设置支持的方向后，当前控制器以及子控制器都会遵守这个方向
    //视频播放 用modal来展示，旋转
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.portrait
    
    }
    
    
    @objc private func userlogin(n:Notification){
        var when = DispatchTime.now()
        if n.object != nil{//token 过期 提示重新登录
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "登录超时，需要重新登录")
            when = DispatchTime.now() + 1.5 //需要延长 提示1.5秒
        }
        DispatchQueue.main.asyncAfter(deadline: when) {
            SVProgressHUD.setDefaultMaskType(.clear)
            //前往等路页面
            let nv = UINavigationController(rootViewController: WBOAuthController())
            self.present(nv, animated: true, completion: nil)
        }
      
        
    }
    
    
    
    //私用控件
    fileprivate lazy var composeButton : UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    //撰写微博
    @objc fileprivate func composeStatus() -> () {
        //print("撰写微博")
        // 0 判断是否登录//FIXME: -
        // 1 实例化视图
        let v = WBComposeView.WBComposeView()
        
        // 2 显示视图
        v.show { [weak v] (clsName) in
           // print("前往目标 \(clsName ?? "")")
            guard let clsName = clsName,
                  let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type else{
                v?.removeFromSuperview()
                return
            }
            //FIXME: -闪退问题
            let vc = cls.init()
            let nav  = UINavigationController(rootViewController: vc)
            v?.removeFromSuperview()
            self.present(nav, animated: true){
//                v?.removeFromSuperview()
            }

        }
        
    }
    
}
// MARK: -时钟
extension MainViewController{
    func setupTimer() -> () {
        timer = Timer.scheduledTimer(timeInterval: 360.0, target: self, selector:#selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    // 时钟触发方法
    @objc private func updateTimer(){
        if !NetWorkManager.shared.userlogon{
            return
        }
        NetWorkManager.shared.unreadCount { (count) in
//            print("检测到\(count)条新微博")
            //设置首页tab bageNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            //ios8.0后要用户授权后才能显示
            UIApplication.shared.applicationIconBadgeNumber =  count
            
        }
        
        
    }
    
    
    
    
}

extension MainViewController{
   private func setupNewFeature()  {
      //0 是否登录
      if !NetWorkManager.shared.userlogon{
          return
      }
      //1 检查版本是否更新
    
      //2 如果更新显示新特效
      let v = isNewVersion ? WBNewFeatureView.newFeatureView() : WBWelcomeView.welcomeView()
      view.addSubview(v)
      //3 否则显示欢迎
    
    
    }
    //extension 中可以有计算型属性，不会占用存储空间
    //主版本号 次版本号 修订版本号
    private var isNewVersion:Bool{
        //1 取出当前版本号1.0.2
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        //2 取出沙盒中备份的版本号1.0.2
        let path:String = ("version" as NSString).cz_appendDocumentDir()
        let sandboxVersion = (try? String(contentsOfFile: path)) ?? ""
        //3 将当前版本好存到沙盒1.0.2
        _ = try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        //4 返回两个版本号比较是否一致
        return currentVersion != sandboxVersion
    }
    
    
    
}


extension MainViewController:UITabBarControllerDelegate{
    /// 将要选择tabbar
    ///
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: 目标控制器
    /// - Returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //1 获取控制器在数组中索引
        let idx = viewControllers?.index(of: viewController)
        //2 当前页是首页，又点击首页，重复点击
        if selectedIndex == 0 && idx == selectedIndex {
          //  print("点击首页")
            //表格滚到顶部
            //获取控制器
            let nav  =  childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! HomeViewController
            //滚动到首页
            vc.tableView?.setContentOffset(CGPoint(x:0,y:-64), animated: true)
            //刷新表格 增加延迟，让表格先滚动到顶部再刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                  vc.loadData()
            })
            //清楚tabbar item bagenumber
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
            
        }
        //判断目标控制器是否是UIViewController
        return !viewController.isMember(of: UIViewController.self)
        
    }
    
    
    
    
}



/* extension类似oc分类，切分代码块
   可以把相近功能的函数放在一个extension中便于维护
   extension扩展只能添加些的计算属性，但不能添加存储属性，也不能像已有属性添加属性观察
 */
 extension MainViewController {
    //设置添加按钮
   fileprivate func setupComposeButton(){
        tabBar.addSubview(composeButton)
        //按钮高度
        let count = CGFloat(childViewControllers.count)
        //按钮宽度
        let w = tabBar.bounds.width / count
        composeButton.frame = tabBar.bounds.insetBy(dx: 2*w, dy: 0)
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    
    }
    //设置所有子控制器
   fileprivate  func setupChildController(){
    //0.获取沙盒的路径
    let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let jsonPath = (docDir as NSString).appendingPathComponent("MainVC.json")
    var data  = NSData(contentsOfFile: jsonPath)
    if data == nil{
        //从Bundle 加载data
        let path =  Bundle.main.path(forResource: "MainVC.json", ofType: nil)
        data  = NSData(contentsOfFile: path!)
    }
    //从bundle 中加载 json  1 路径 2 加载data 3 反序列化
    //3.将Data转成数组
    guard  let anyObject = try? JSONSerialization.jsonObject(with: data! as Data, options: .mutableContainers)
        else {
        return
    }
    guard let array = anyObject as? [[String : AnyObject]] else{
        return
    }
    //遍历数组，循环创建控制器数组
        var arrarM = [UIViewController]()
        for dict in array {
            //把生成的控制器加入数组
            arrarM.append(controller(dict: dict))
        }
       //设置控制器子控制器
        viewControllers = arrarM
    
    }
    
    //使用字典创建一个子控制器
    // dict: clsName titile imageName

   fileprivate  func controller(dict:[String:AnyObject])->UIViewController{
        //1，取得字典内容
        guard let clsName =   dict["clsName"] as AnyObject?,
            let title =     dict["title"] as AnyObject?,
            let imageName =  dict["imageName"] as AnyObject?,
            let cls = NSClassFromString(Bundle.main.namespace+"."+(clsName as! String)) as? BaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String:String]
            else{
                return UIViewController()
        }
        //2，创建视图控制器
        let vc = cls.init()
        vc.title = title as? String
        //访客视图的数组赋值
        vc.visitorInfoDic = visitorDict
        //3, 设置图标
        vc.tabBarItem.image = UIImage(named: "tabbar_"+(imageName as! String))
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_"+(imageName as! String)+"_selected")?.withRenderingMode(.alwaysOriginal)
        //4,设置标题样式
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.orange],
                                             for: .selected)
         //系统默认12号字 ，要设置normal 字体大小
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)],
                                             for: UIControlState.normal)
        
        //实例化导航控制器的时候，会调用push方法将rootVC压栈
        let nav = MainNavigationController(rootViewController: vc)
        return nav
        
        
    }
    

    
}

