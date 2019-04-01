//
//  LightEditVC.swift
//  Sample
//
//  Created by 张飞 on 2019/4/1.
//  Copyright © 2019 张飞. All rights reserved.
//

import UIKit

class LightEditVC: UIViewController {

    @IBOutlet weak var namTF: UITextField!
    var cid = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let dev = DataBase.device(cid: cid, typeId: "0"){
            namTF.text = dev.name
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        let alt = UIAlertController(title: "提示", message: "确定要删除这个设备吗？", preferredStyle: .alert)
        let act1 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let act2 = UIAlertAction(title: "确定", style: .default) { (_) in
            DataBase.delete(typeId: "0", cid: self.cid)
            self.navigationController?.popToRootViewController(animated: true)
        }
        alt.addAction(act1)
        alt.addAction(act2)
        present(alt, animated: true, completion: nil)
    }
    
    @IBAction func chengAction(_ sender: Any) {
        if namTF.text!.count == 0{
            MBProgressHUD.showText("请输入设备别名！")
            return
        }
        if let _ = DataBase.device(cid: cid, typeId: "0"){
            DataBase.update(cid: cid, typeId: "0", name: namTF.text!)
            navigationController?.popViewController(animated: true)
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
