//
//  ViewController.swift
//  Sample
//
//  Created by 张飞 on 2019/3/29.
//  Copyright © 2019 张飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var devices:[DBDevice] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let devs = DataBase.allDevices(typeId: "0")
        devices = devs
        for dbDev in devs {
            let dev = Device()
            dev.cid = dbDev.cid
            dev.deviceId = dbDev.did
            dev.passWord = dbDev.cidPwd
            dev.host = ""
            WiseAPI.shared().defaultDeviceManager.add(dev)
        }
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "config"{
            let vc = segue.destination as! LightConfigVC
            let row = sender as! Int
            let dev = devices[row]
            vc.cid = dev.cid
        }
    }
}
class MainCell: UITableViewCell {
    @IBOutlet weak var mainLab: UILabel!
    @IBOutlet weak var onLineLab: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
        let dbDev = devices[indexPath.row]
        cell.mainLab.text = dbDev.name
        let dev = WiseAPI.shared().defaultDeviceManager.getDeviceWithCid(dbDev.cid)
        if dev.onlineState == 0{
            cell.onLineLab.text = "正在连接..."
        }else if dev.onlineState == -1{
            cell.onLineLab.text = "未连接"
        }else if dev.onlineState == 1{
            cell.onLineLab.text = "已连接"
        }
        dev.onlineStateChangeCallBack = { state in
            if state == 0{
                cell.onLineLab.text = "正在连接..."
            }else if state == -1{
                cell.onLineLab.text = "未连接"
            }else if dev.onlineState == 1{
                cell.onLineLab.text = "已连接"
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "config", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
