//
//  WiseAPI.h
//  wisde
//
//  Created by 张飞 on 2019/3/27.
//  Copyright © 2019 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceManager.h"
#import "Device.h"
#import "DataModel.h"
#import "UdpSocketManager.h"
#import "DataHelper.h"
#import "SsidHelper.h"
#import "EspTouchHelper.h"
#import "SearchHelper.h"
#import "DeviceAddHelper.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBack)(void);

@interface WiseAPI : NSObject
@property(nonatomic,strong)DeviceManager *defaultDeviceManager;

+(instancetype)shared;
+(void)initWithAppKey:(NSString *)key;
+(NSTimeInterval)timeNow;
+(void)senCmdWithDeviceId:(NSString *)cid
                     body:(NSString *)body
                 callBack:(void(^)(NSDictionary *response, NSError *error))callBack;
+(void)sendAddCmdWithHost:(NSString *)host
                     code:(NSString *)code
                      cid:(NSString *)cid
                   cidPwd:(NSString *)cidPwd
                   others:(NSArray *)others
                 callBack:(void(^)(bool isSuccess,NSString *des))callBack;
+(void)sendCmdWithHost:(NSString *)host
                  code:(NSString *)code
                   cid:(NSString *)cid
                others:(NSArray *)others
              callBack:(void(^)(bool isSuccess,NSString *des))callBack;
@end

NS_ASSUME_NONNULL_END
