//
//  DeviceAddHelper.h
//  Sample
//
//  Created by 张飞 on 2019/3/30.
//  Copyright © 2019 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceAddHelper : NSObject
+(void)addDeviceWithCid:(NSString *)cid
                   host:(NSString *)host
                 devPwd:(NSString *)devPwd
                timeOut:(int)seconds
               callBack:(void(^)(bool isSuccess, NSString * _Nonnull des))callBack;
@end

NS_ASSUME_NONNULL_END
