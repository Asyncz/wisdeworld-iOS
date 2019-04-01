# wisdeworld-iOS
智慧世界sdk的iOS版本

智慧世界WiFi调光模块的iOS SDK。

## [wisdeworld-Android](https://github.com/Asyncz/wisdeworld-Android)

## 使用

将`WiseSDK.framework`引入到项目中。配置`Access WiFi Information`为`on`（需要在开发者账号对应的id配置中做相关配置）。

info.plists中添加

```xml
<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
```

## 示例

### 引入

```objective-c
#import <WiseSDK/WiseAPI.h>
```

### 初始化

```swift
WiseAPI.initWithAppKey("***********")
```

### 一键配网

```swift
EspTouchHelper.config(withSsid: wifiName, bSsid: wifiBssid, pwd: wifiPwd, devPwd: devPwd, count: count, delegate: self)

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
```

### 添加设备，获取设备id

```swift
DeviceAddHelper.addDevice(withCid: cid, host: ip, devPwd: devPwdLab.text!, timeOut: 3) { (isSuccess, des) in
            if isSuccess{
                print("设备id(cid)：\(des)")
            }else{
                print("错误原因：\(des)")
            }
        }
```

### 将已添加的设备进行管理

```swift
for dbDev in devs {
            let dev = Device()
            dev.cid = dbDev.cid
            dev.deviceId = dbDev.did
            dev.passWord = dbDev.cidPwd
            dev.host = ""
            WiseAPI.shared().defaultDeviceManager.add(dev)
        }
```

### 在线状态管理

```swift
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
```

### 发送命令

```swift
dev.sendCmd(withCode: "102", body: "cmd-on") { (code, dic) in
                print(code)
                print(dic)
            }
```

## 其它

该项目最终解释权归深圳市智慧世界信息技术有限公司所有