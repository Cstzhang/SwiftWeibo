//
//  BaseViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

//OC中不支持多继承，使用协议替代，Swift的写法更类似于多继承
class BaseViewController: UIViewController {
    // MARK: -设置属性
    //访客视图字典
    var visitorInfoDic : [String :String]?

    //表格视图 用户没有登录就不创建
    var tableView : UITableView?
    //刷新控件
    var refreshControl:UIRefreshControl?
    // 上拉刷新标志
    var isPullup = false
    //自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    //navItem 后面设置导航条都要用这个进行设置
    lazy var navItem = UINavigationItem()
    
    // MARK: -加载
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NetWorkManager.shared.userlogon ?  loadData() : ()//加载数据
        //注册通知
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loginSuccess),
                                               name: NSNotification.Name(rawValue: WBUserShouldLoginNotification),
                                               object: nil)
        
    }
    deinit {
        //注册通知
        NotificationCenter.default.removeObserver(self)
    }
    //设置导航栏title 重写 title的set方法
    override var title: String? {
        didSet{
          navItem.title = title
        }
    }
    //加载数据源， 具体实现由子类负责
    @objc func loadData()  {
        //如果子类不实现任何方法，默认关闭刷新控件
        refreshControl?.endRefreshing()
    }
    
    @objc fileprivate func loginSuccess(n:Notification){
        print("登录成功 \(n)")
        //访客视图替换成表格视图,重新设置View
        //当访问view 的getter方法时  如view =nil ，会调用loadView -> viewdidload方法
        view = nil
        //注销通知 重新执行viewDidload 会再次注册通知
        NotificationCenter.default.removeObserver(self)
    }
    

}

extension BaseViewController{
    @objc fileprivate func login(){
        print("login")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    
    @objc fileprivate func register(){
        print("register")

    }
    
    
}






// MARK: -导航相关
extension BaseViewController{
   fileprivate func setupUI() {
        view.backgroundColor=UIColor.white
        //取消自动缩进 如果隐藏了导航栏，会缩进20px
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        //登录设置表格，未登录显示访客视图
        NetWorkManager.shared.userlogon ? setupTableView() : setupVisitorView()
        
    }
    
    //创建表格 用户登录之后（子类重写此方法，子类不需要关系用户登录之前的逻辑）
   @objc  func  setupTableView(){
       tableView = UITableView(frame: view.bounds, style: .plain)
       view.insertSubview(tableView!, belowSubview: navigationBar)
       //设置数据源&代理 子类实现数据源方法
       tableView?.dataSource = self
       tableView?.delegate = self
       //设置内容缩进
       tableView?.contentInset = UIEdgeInsetsMake(navigationBar.bounds.height,
                                               0,
                                               tabBarController?.tabBar.bounds.height ?? 49,
                                               0)
       //设置刷新控件
       //1 实例化控件
       refreshControl = UIRefreshControl()
       //2 添加到表格视图
       tableView?.addSubview(refreshControl!)
       //3 添加监听方法
       refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    
        
    }
    
    //未登录视图
    private func  setupVisitorView(){
      print("访客视图")
      let visitorView = VisitorView(frame: view.bounds)
      view.insertSubview(visitorView, belowSubview: navigationBar)
      //访客视图数据
      visitorView.visitorInfo = visitorInfoDic
      //监听访客视图按钮
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
     //设置导航条按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(register))
        
    }
    
    //设置导航条
    private func setupNavigationBar(){
        view.addSubview(navigationBar)
        //navigationBar上面添加navItem
        navigationBar.items=[navItem]
        //navigationBar 的渲染颜色（系统默认导航栏右侧高亮）（导航条背景颜色）
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        //设置 navBar title 字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.darkGray]
        //设置系统按钮的文字渲染颜色
        navigationBar.tintColor = UIColor.orange
        
     
    
    }
    
    
}


// MARK: -UITableViewDataSource,UITabBarDelegate
//extension 中不能有属性，extension中不能重写父类本类方法-不是扩展的方法（父类extension可以），重写父类方法是子类的职责，extension是对类的扩展
extension BaseViewController:UITableViewDataSource,UITableViewDelegate{
    //基类只是准备方法，子类负责具体实现(保障没有语法错误)
    //子类的数据源方法不需要super
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let row = indexPath.row
        let section = tableView.numberOfSections-1
        //没有数据的话直接返回
        if row < 0 || section < 0 {
            return
        }
        //最后一行
        let count  = tableView.numberOfRows(inSection: section)
        //是最后一行，且没有在进行刷新
        if row == (count - 1) && !isPullup{
            print("上拉刷新")
            isPullup = true
            //开始刷新
            loadData()
        }
        
        
    
    }


}
