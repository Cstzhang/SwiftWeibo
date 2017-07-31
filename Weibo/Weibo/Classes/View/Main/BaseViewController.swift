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
    //表格视图 用户没有登录就不创建
    var tableView : UITableView?
  
    //自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    //navItem 后面设置导航条都要用这个进行设置
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    //设置导航栏title 重写 title的set方法
    override var title: String? {
        didSet{
          navItem.title = title
        
        }
    
    }
    //加载数据源， 具体实现由子类负责
    func loadData()  {
        
    }
    

}





//导航相关
extension BaseViewController{
    func setupUI()  {
        view.backgroundColor=UIColor.cz_random()
        setupTableView()
        setupNavigationBar()
        
    }
    //创建表格
    private func  setupTableView(){
       tableView = UITableView(frame: view.bounds, style: .plain)
       view.insertSubview(tableView!, belowSubview: navigationBar)
       //设置数据源&代理 子类实现数据源方法
       tableView?.dataSource = self
       tableView?.delegate = self as? UITableViewDelegate
    }
    
    //设置导航条
    private func setupNavigationBar(){
        view.addSubview(navigationBar)
        //navigationBar上面添加navItem
        navigationBar.items=[navItem]
        //navigationBar 的渲染颜色（系统默认导航栏右侧高亮）
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        //设置 navBar title 字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
    
    }
    
    
}


// MARK: -UITableViewDataSource,UITabBarDelegate
//extension 中不能有属性，extension中不能重写父类方法，重写父类方法是子类的职责，extension是对类的扩展
extension BaseViewController:UITableViewDataSource,UITabBarDelegate{
    //基类只是准备方法，子类负责具体实现(保障没有语法错误)
    //子类的数据源方法不需要super
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }




}
