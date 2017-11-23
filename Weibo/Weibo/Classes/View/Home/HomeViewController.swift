//
//  HomeViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
//原创weibo
private let originalCellId = "originalCellId"
//转发微博
private let retweetedcellId = "retweetedcellId"

class HomeViewController: BaseViewController {
//    fileprivate lazy var statusList = [String]()
    fileprivate lazy var listViewModel = WBStatusListViewModel()
    //加载数据源 假数据
    override func loadData() {
        print("准备刷新")
        refreshControl?.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2 ) {
            self.listViewModel.loadStatus(pullop: self.isPullup) { (isSuccess,hasMorePullup) in
                //结束刷新
                self.refreshControl?.endRefreshing()
                //            print("刷新表格")
                self.isPullup = false
                //刷新表格数据
                if hasMorePullup{
                    self.tableView?.reloadData()
                }
            }
        }
  
    }
    
    //显示好友的方法
    @objc fileprivate  func showFriends()  {
        print("查看好友")
        let vc = DemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

}

// MARK: - 表格数据源方法

extension HomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 根据视图模型判断可用cell
        let vm =  listViewModel.statusList[indexPath.row]
        let cellId = (vm.status.retweeted_status != nil) ? retweetedcellId : originalCellId
        
        //取cell 会调用代理方法获取cell高，如果没有，找到cell按照自动布局规则进行计算，找到向下的约束，计算动态行高
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WBStatusCell
      
        cell.viewModel = vm
        return cell
        
    }
    
    // 父类要实现代理方法，子类才能重写 swift 3.0   2.0 不用
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vm = listViewModel.statusList[indexPath.row]
        return vm.rowHeight
    }
    
    
    
    

}


extension HomeViewController{
    

    //navigationItem重写 设置导航栏按钮
    override func setupTableView() {
        super.setupTableView()
        //添加左侧按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        //注册cell
       tableView?.register(UINib(nibName: "WBStatusNormalCell", bundle: nil), forCellReuseIdentifier: originalCellId)
       tableView?.register(UINib(nibName: "WBStatusRetweetedCell", bundle: nil), forCellReuseIdentifier: retweetedcellId)
        //设置行高
//        tableView?.rowHeight = UITableViewAutomaticDimension
//        //预估行高
        tableView?.estimatedRowHeight = 300
        //取消分隔线
        tableView?.separatorStyle = .none

        setupNavTitle()
    }
    //设置导航栏
    private func setupNavTitle()  {
        let titleName = NetWorkManager.shared.userAccount.screen_name
        let titleButton  = WBTitleButton(title: titleName)
        navItem.titleView = titleButton
        titleButton.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
  
    }
    @objc func clickTitleButton(btn:UIButton){
        btn.isSelected = !btn.isSelected
    }
    
    
    
}

