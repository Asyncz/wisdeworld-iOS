//
//  WiFiSettingVC.swift
//  Sample
//
//  Created by 张飞 on 2019/3/29.
//  Copyright © 2019 张飞. All rights reserved.
//

import UIKit

class WiFiSettingVC: UIViewController {

    @IBOutlet weak var wifiNameLab: UILabel!
    @IBOutlet weak var wifiPwdTF: UITextField!
    @IBOutlet weak var devicePwdTF: UITextField!
    @IBOutlet weak var countTF: UITextField!
    
    let timer = DispatchSource.makeTimerSource()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timer.schedule(deadline: .now(), repeating: .seconds(1), leeway: .microseconds(100))
        timer.setEventHandler {
            DispatchQueue.main.async {
                self.wifiNameLab.text = SsidHelper.fetchSsid()
            }
        }
        timer.resume()
        
        if SsidHelper.fetchSsid() == "" {
            let alt = UIAlertController(title: "提示", message: "请将手机连接到需要配置的WiFi网络", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default)
            alt.addAction(action)
            self.present(alt, animated: true, completion: nil)
        }
        
        countTF.addTarget(self, action: #selector(editChanged), for: .editingDidEnd)
    }
    @objc func editChanged() {
        if countTF.text?.count ?? 0 == 0 || countTF.text! == "0"{
            countTF.text = "1"
        }
    }
    
    @IBAction func nextClick(_ sender: Any) {
        print(judgeTheillegalCharacter(content: devicePwdTF.text!))
        if self.wifiNameLab.text == "" {
            let alt = UIAlertController(title: "提示", message: "尚未获取WiFi信息，请确认已将手机连接到需要配置的WiFi网络", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default)
            alt.addAction(action)
            self.present(alt, animated: true, completion: nil)
            return
        }
        if wifiPwdTF.text?.count ?? 0 < 8 {
            MBProgressHUD.showText("请输入WiFi密码")
            return
        }
        if devicePwdTF.text?.count ?? 0 < 3{
            MBProgressHUD.showText("请输入设备密码")
            return
        }
        if !judgeTheillegalCharacter(content: devicePwdTF.text!) {
            MBProgressHUD.showText("设备密码中不能包含特殊字符")
            return
        }
        
        self.performSegue(withIdentifier: "next", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let vc = segue.destination as! WiFiConfigVC
            vc.wifiName = wifiNameLab.text!
            vc.wifiPwd = wifiPwdTF.text!
            vc.count = countTF.text!
            vc.wifiBssid = SsidHelper.fetchBssid()
            vc.devPwd = devicePwdTF.text!
        }
    }
    func judgeTheillegalCharacter(content:String) -> Bool {
        let str = "^[A-Za-z0-9]+$"
        // NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        let isValid = predicate.evaluate(with: content)
        return isValid
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
