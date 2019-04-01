//
//  WiFiConfigVC.swift
//  Sample
//
//  Created by 张飞 on 2019/3/30.
//  Copyright © 2019 张飞. All rights reserved.
//

import UIKit

class WiFiConfigVC: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tipLab: UILabel!
    
    var wifiName = ""
    var wifiPwd = ""
    var wifiBssid = ""
    var devPwd = ""
    var count = ""
    var num = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        EspTouchHelper.config(withSsid: wifiName, bSsid: wifiBssid, pwd: wifiPwd, devPwd: devPwd, count: count, delegate: self)
    }
    
    @IBAction func btnClick(_ sender: Any) {
        EspTouchHelper.cancel()
        if button.titleLabel?.text != "停止" {
            performSegue(withIdentifier: "search", sender: nil)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        EspTouchHelper.cancel()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension WiFiConfigVC:ESPTouchHelperDelegate{
    func espTouchCanceled() {
        tipLab.text = "已取消"
        button.setTitle("添加设备", for: .normal)
    }
    
    func espTouchFailed() {
        tipLab.text = "配置失败"
        button.setTitle("添加设备", for: .normal)
    }
    
    func espTouchSuccessed(withResults arr: [Any]) {
        let str = "配置完成，" + String(arr.count) + "个设备配置成功"
        tipLab.text = str
        button.setTitle("添加设备", for: .normal)
    }
    
    func espTouchDidAdd(withResult dic: [AnyHashable : Any]) {
        num = num + 1
        tipLab.text = "正在配置..."+String(num) + "个设备配置成功"
    }
}
