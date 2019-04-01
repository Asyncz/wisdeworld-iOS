//
//  UdpSocketManager.h
//  MeiYanBao
//
//  Created by 张飞 on 2017/2/27.
//  Copyright © 2017年 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"


@interface UdpSocketManager : NSObject<GCDAsyncUdpSocketDelegate>


-(void)receiveWithPort:(int)port error:(NSError **)errPtr callBack:(void(^)(NSString *data,NSString *ip))callBack;
-(void)closeSocket;
-(void)sendToHost:(NSString *)host
             port:(int)port
           string:(NSString *)string
      withTimeout:(NSTimeInterval)timeout
              tag:(long)tag
         callBack:(void(^)(bool isSuccess,NSString *des))callBack;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (BOOL)isValidatIP:(NSString *)ipAddress;
@end
