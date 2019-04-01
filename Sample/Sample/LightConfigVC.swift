//
//  LightConfigVC.swift
//  Sample
//
//  Created by 张飞 on 2019/4/1.
//  Copyright © 2019 张飞. All rights reserved.
//

import UIKit

class LightConfigVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let cmds = ["开灯","关灯","红灯","绿灯","蓝灯","闪烁","渐变"]
    var cid = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func selected(row:Int) {
        let dev = WiseAPI.shared().defaultDeviceManager.getDeviceWithCid(cid)
        switch row {
        case 0:
            dev.sendCmd(withCode: "102", body: "cmd-on") { (code, dic) in
                print(code)
                print(dic)
            }
            break
        case 1:
            dev.sendCmd(withCode: "103", body: "cmd-off") { (code, dic) in
                print(code)
                print(dic)
            }
            break
        case 2:
            dev.sendCmd(withCode: "104", body: "cmd-red") { (code, dic) in
                print(code)
                print(dic)
            }
            break
        case 3:
            dev.sendCmd(withCode: "105", body: "cmd-green") { (code, dic) in
                print(code)
                print(dic)
            }
            break
        case 4:
            dev.sendCmd(withCode: "106", body: "cmd-blue") { (code, dic) in
                print(code)
                print(dic)
            }
            break
        case 5:
            dev.sendCmd(withCode: "107", body: "cmd-def1") { (code, dic) in
                print(code)
                print(dic)
            }
            break
        case 6:
            dev.sendCmd(withCode: "108", body: "cmd-def2") { (code, dic) in
                print(code)
                print(dic)
            }
            break
        default:
            return
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //storyboard中的点击s
        if segue.identifier == "edit" {
            let vc = segue.destination as! LightEditVC
            vc.cid = cid
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
extension LightConfigVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cmds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cmds[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selected(row: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
