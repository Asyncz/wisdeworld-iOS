//
//  DeviceAddVC.swift
//  Sample
//
//  Created by 张飞 on 2019/3/30.
//  Copyright © 2019 张飞. All rights reserved.
//

import UIKit

class DeviceAddVC: UIViewController {
    
    @IBOutlet weak var cidLab: UILabel!
    @IBOutlet weak var devNameLab: UITextField!
    @IBOutlet weak var devPwdLab: UITextField!
    
    var ip = ""
    var cid = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        cidLab.text = cid
    }
    
    @IBAction func addClick(_ sender: Any) {
        if devNameLab.text?.count ?? 0 == 0 {
            MBProgressHUD.showText("请输入设备别名！")
            return
        }
        if devPwdLab.text?.count ?? 0 == 0 {
            MBProgressHUD.showText("请输入设备密码！")
            return
        }
        DeviceAddHelper.addDevice(withCid: cid, host: ip, devPwd: devPwdLab.text!, timeOut: 3) { (isSuccess, des) in
            if isSuccess{
                let dev = DataBase.device(cid: self.cid, typeId: "0")
                if dev != nil{
                    MBProgressHUD.showText("设备已添加！")
                    return
                }
                print("设备id(cid)：\(des)")
                DataBase.insert(name: self.devNameLab.text!, cid: self.cid, cidPwd: self.devPwdLab.text!, typeId: "0", deviceId: des)
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                print("错误原因：\(des)")
                MBProgressHUD.showText(des)
            }
        }
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
