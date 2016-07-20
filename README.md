# TSLocationManager
TSLocationManager is a simple packaging of CoreLocation</br>

>1. what kan the TSLocationManager do</br>
its easy to use TSLocationManager to get location and address</br>
use the CoreLocation from iOS SDK ,so we dont need add another SDK</br>
so its easy！</br>
我们可以用TSLocationManager获取经纬度和地址信息，精确到10米。（即街道，号码）</br>
使用苹果官方SDK，所以我们不需要添加额外的东西</br>
使用起来真的很简单！</br></br>

>2. you need to add key(NSLocationAlwaysUsageDescription) in the info.plist to get location authority,and the value is the message
will show in alert</br>
需要在info中加入这一键值，通过这一键值来提醒获取定位权限，值为提示信息</br>
`NSLocationAlwaysUsageDescription`</br>

>3. you can use the method</br>
`+ (instancetype)shareManager;`</br>
to get a shared property and use the method</br>
`- (void)startLocatWithCompleteBlock:(void (^)(NSError * error, NSDictionary * addressDic,CLLocation * location))complete;`</br>
to get the address and location</br>
我们可以使用上面的两个方法获取经纬度和地址</br>
![image](https://github.com/TsnumiDC/TSLocationManager/blob/master/TSLoCationManagerDemo/DDBB6219606F84DDE6B53DF56F7A2C20.png)

<p>Dylan make it </p>
[You can visit my blog: blog.dylancc.com](https://blog.dylancc.com)
