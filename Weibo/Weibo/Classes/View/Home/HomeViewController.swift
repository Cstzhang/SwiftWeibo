//
//  HomeViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class HomeViewController: BaseViewController {
//    fileprivate lazy var statusList = [String]()
    fileprivate lazy var listViewModel = WBStatusListViewModel()
    //加载数据源 假数据
    override func loadData() {
        listViewModel.loadStatus(pullop: self.isPullup) { (isSuccess,hasMorePullup) in
            //结束刷新
            self.refreshControl?.endRefreshing()
            print("刷新表格")
            self.isPullup = false
            //刷新表格数据
            if hasMorePullup{
                self.tableView?.reloadData()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        
        return cell
        
    }

}


extension HomeViewController{
    

    //navigationItem重写 设置导航栏按钮
    override func setupTableView() {
        super.setupTableView()
        //添加左侧按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        //注册cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    
    
}

