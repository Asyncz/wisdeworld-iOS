//
//  DataBase.swift
//  SmartWorld
//
//  Created by 张飞 on 2017/12/29.
//  Copyright © 2017年 张飞. All rights reserved.
//

import UIKit
import SQLite

class DataBase {
    static let dataBase = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/db.sqlite3"
    
    static let shared = DataBase()
    let db = try? Connection(dataBase)
    
    let table = Table("db_device")
    
    let id = Expression<Int64>("id")
    let name = Expression<String?>("name")
    let cid = Expression<String?>("cid")
    let cidPwd = Expression<String?>("cidpwd")
    let typeId = Expression<String?>("typeid")
    let did = Expression<String?>("did")
    
    init() {
        
        try! db?.run(table.create(ifNotExists: true, block: { (tab) in
            tab.column(id, primaryKey: true)
            tab.column(name)
            tab.column(cid)
            tab.column(cidPwd)
            tab.column(typeId)
            tab.column(did)
        }))
    }
    
    /// 新增
    static func insert(name:String,cid:String,cidPwd:String,typeId:String,deviceId:String) {
        let insert = shared.table.insert(shared.name <- name, shared.cid<-cid,shared.cidPwd<-cidPwd,shared.typeId<-typeId,shared.did<-deviceId)
        try! shared.db?.run(insert)
    }
    
    /// 搜索
    static func devices(typeId:String) -> [DBDevice]{
        let devs = try! shared.db?.prepare(shared.table.filter(shared.typeId == typeId))
        var arr = Array<DBDevice>()
        for dev in devs! {
            let d = DBDevice(name: dev[shared.name]!, cid: dev[shared.cid]!, cidPwd:dev[shared.cidPwd]!,did:dev[shared.did]!)
            arr.append(d)
        }
        return arr
    }
    static func allDevices(typeId:String) -> [DBDevice]{
        let devs = try! shared.db?.prepare(shared.table.filter(shared.typeId == typeId))
        var arr = Array<DBDevice>()
        for dev in devs! {
            let d = DBDevice(name: dev[shared.name]!, cid: dev[shared.cid]!, cidPwd:dev[shared.cidPwd]!,did:dev[shared.did]!)
            arr.append(d)
        }
        return arr
    }
    static func device(cid:String,typeId:String) -> DBDevice?{
        if let rows = try! shared.db?.prepare(shared.table.filter(shared.cid == cid && shared.typeId == typeId)) {
            for row in rows{
                let dev = DBDevice(name: row[shared.name]!, cid: row[shared.cid]!, cidPwd:row[shared.cidPwd]!,did:row[shared.did]!)
                return dev
            }
        }
        return nil;
    }
    /// 删除
    static func delete(typeId:String = "",cid:String = ""){
        if typeId == "" && cid == "" {
            return
        }else{
            if typeId != "" {
                try! shared.db?.run(shared.table.filter(shared.typeId == typeId).delete())
            }
            if cid != "" {
                try! shared.db?.run(shared.table.filter(shared.cid == cid).delete())
            }
        }
    }
    
    /// 修改
    static func update(cid:String,typeId:String,name:String){
        if name != "" && typeId != ""{
            try! shared.db?.run(shared.table.filter(shared.cid == cid && shared.typeId == typeId).update(shared.name <- name))
        }
    }
}
struct DBDevice {
    var name:String = ""
    var cid:String = ""
    var cidPwd:String = ""
    var did:String = ""
}
