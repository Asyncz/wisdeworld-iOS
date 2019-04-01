//
//  SearchVC.swift
//  Sample
//
//  Created by 张飞 on 2019/3/30.
//  Copyright © 2019 张飞. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var list:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SearchHelper.search { (arr) in
            self.list = arr
            self.tableView.reloadData()
            self.tipLab.isHidden = arr.count != 0
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let index = sender as! Int
            let vc = segue.destination as! DeviceAddVC
            let dic = list[index] as! [String:String]
            vc.ip = dic["ip"] ?? ""
            vc.cid = dic["cid"] ?? ""
        }
    }
}

extension SearchVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dic = list[indexPath.row] as! [String:String]
        cell.textLabel?.text = dic["cid"]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dic = list[indexPath.row] as! [String:String]
        let cid = dic["cid"];
        let dev = DataBase.device(cid: cid!, typeId: "0")
        if dev != nil{
            MBProgressHUD.showText("设备已添加！")
            return
        }
        self.performSegue(withIdentifier: "add", sender: indexPath.row)
    }
    
}

