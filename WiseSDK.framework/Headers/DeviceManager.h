//
//  DeviceManager.h
//  wisde
//
//  Created by 张飞 on 2019/3/27.
//  Copyright © 2019 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"
#import "DataModel.h"
#import "UdpSocketManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface DeviceManager : NSObject
@property(nonatomic,strong)UdpSocketManager *udpManager;
@property(nonatomic,strong)void(^mReciveCallBack)(DataModel *data,NSString *ip);
@property(nonatomic,strong)void(^mSearchCallBack)(DataModel *data,NSString *ip);


+(instancetype)initWithUdpPort:(int)port;
-(void)addDevice:(Device *)device;
-(void)addDevices:(NSArray *)devs;
-(void)removeDevice:(Device *)dev;
-(NSUInteger)devcieSize;
-(Device *)getDeviceWithCid:(NSString *)cid;
-(void)setReciveCallBack:(void(^)(DataModel *data,NSString *ip))callBack;
-(void)setSearchCallBack:(void(^)(DataModel *data,NSString *ip))callBack;
@end

NS_ASSUME_NONNULL_END
