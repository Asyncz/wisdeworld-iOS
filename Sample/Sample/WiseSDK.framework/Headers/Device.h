//
//  Device.h
//  wisde
//
//  Created by 张飞 on 2019/3/27.
//  Copyright © 2019 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Device : NSObject
@property(nonatomic,copy)NSString *cid;
@property(nonatomic,copy)NSString *host;
@property(nonatomic,copy)NSString *deviceId;
@property(nonatomic,copy)NSString *passWord;
@property(nonatomic,assign)int onlineState;
@property(nonatomic,copy)void(^reciveCallBack)(DataModel *data);
@property(nonatomic,copy)void(^onlineStateChangeCallBack)(int onlineState);

-(void)reciveData:(DataModel *)data ip:(NSString *)ip;
-(void)checkOnline;
-(void)sendCmdWithCode:(NSString *)code
                  body:(NSString *)body
                values:(NSArray *)values
              callBack:(void(^)(int code,NSDictionary *respons))callBack;
-(void)sendCmdWithCode:(NSString *)code
                  body:(NSString *)body
              callBack:(void(^)(int code,NSDictionary *respons))callBack;
@end

NS_ASSUME_NONNULL_END
