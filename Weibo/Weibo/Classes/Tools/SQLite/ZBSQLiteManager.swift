//
//  ZBSQLiteManager.swift
//  FMDBHandle
//
//  Created by 恒信永利 on 2017/12/1.
//  Copyright © 2017年 zhangzhengbin. All rights reserved.
//
/*
SQLite管理器
*/
import Foundation
import FMDB

class ZBSQLiteManager {
//全局数据库单例
static let shared = ZBSQLiteManager()
    //数据库队列
    let queue:FMDatabaseQueue
    //构造函数 加private防止外部访问
    private init(){
       //数据的路径 -path
        let dbName  = "zbDatabase.db"
        var path  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        path = (path as NSString).appendingPathComponent(dbName)
        print("db path : \(path)")
        //创建数据库队列 同事创建或者打开数据库
        queue = FMDatabaseQueue(path: path)
        //打开数据库
        creatTable()
    }

}

//MARK: -创建数据表以及私有方法
private extension ZBSQLiteManager{
    
    /// 执行sql,返回查询的数组
    ///
    /// - Parameter sql: sql
    /// - Returns: 搜索结果
    func execRecordSet(sql:String) -> [[String:AnyObject]] {
        var result  = [[String:AnyObject]]()
        
       //查询数据，不会修改数据，不会开启事物，事物为了保证数据的有效性，一旦失败可以回滚到初始状态
        queue.inDatabase { (db) in
            guard let re = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            //遍历结果集合进行处理
            while re.next(){
                //获取列数
                let colCount = re.columnCount
                //遍历列获取列名
                for col in 0..<colCount{
                    //列名 KEY
                guard  let name  = re.columnName(for: col),
                    //属性值 Value
                    let value = re.object(forColumnIndex: col) else{
                        continue
                    }
                    result.append([name : value as AnyObject])
                }
            }
        }
        return result
        
    }
    //创建数据表
    func creatTable() -> () {
        // 1 sql
        guard let path  = Bundle.main.path(forResource: "status.sql", ofType: nil),
              let sql  = try? String(contentsOfFile: path) else{
              return
        }
        // 2 执行sql fmdb内部队列 串行队列,同步执行 保证同一时间只有一个任务操作数据库，保证数据库的读写安全
        queue.inDatabase { (db) in
            //只有创建表的时候使用执行多条语句，可以一次创建多个数据表
            //执行增删改查的时候不能使用Statements，否则可能被注入
            if db.executeStatements(sql) == true {
                print("创建表成功")
            }else{
                print("创表失败")
            }
        }
        
        
    }
    
}

//MARK: -数据操作
extension ZBSQLiteManager{
    
    /// 从数据库加载微博数据数组
    ///
    /// - Parameters:
    ///   - userId: 当前登录的用户账号
    ///   - since_id: 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博）
    ///   - max_id: 若指定此参数，则返回ID小于或等于max_id的微博，
    /// - Returns: 返回微博字典数组 将数据库中的status中的数据反序列化 生成字典
    func loadStatus(userId:String,since_id:Int64 = 0,max_id:Int64 = 0) -> [[String:AnyObject]] {
        //1 准备sql
        var sql  = "SELECT status,statusId,userId FROM T_status \n"
        sql += "WHERE userId = \(userId) \n"
        if since_id > 0 {//下拉
           sql += "AND statusId > \(since_id) \n"
        }else if max_id > 0{//上拉
           sql += "AND statusId < \(max_id) \n"
        }
        sql += "ORDER BY statusId DESC LIMIT 20;"
        
        print(sql)
        let array  = execRecordSet(sql: sql)
        //将数组反序列化
        var result = [[String:AnyObject]]()
        for dict in array {
            guard let jsonData = dict["status"] as? Data,
                  let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:AnyObject]
            else{
                continue
            }
            
            //追加到数组
            result.append(json ?? [:])
            
            
        }
        
        return result
    
    }
    /// 新增/修改微博数据,数据属性的时候可能出现重叠
    ///
    /// - Parameters:
    ///   - userId: 当前用户登录的id
    ///   - array:  从网络获取的 '字典数据'
    func updateStatus(userId:String,array:[[String:AnyObject]])  {
        //1，准备sql
        /*
         statusId 当前微博id
         userId 用户id
         status 微博内容
         */
        let sql  = "INSERT OR REPLACE INTO T_status (statusId,userId,status) VALUES (?,?,?);"
        //2, 执行sql
        queue.inTransaction { (db, rollback) in
            //遍历数组，插入数据
            for dict in array{
                guard let statusId  = dict["idstr"] as? String,
                let jsonData  = try? JSONSerialization.data(withJSONObject: dict, options: []) else{
                    continue
                }
                //执行sql
                if db.executeUpdate(sql, withArgumentsIn: [statusId,userId,jsonData]) == false{
                    
                    // -rollback oc : *rollback = YES
                    // swift 1.x 2.x rollback.memory = true
                    rollback.pointee = true
                    break
                }
            }
        }
    }
    
    
    
    
    
    
    
}
