//
//  SsidHelper.h
//  wisde
//
//  Created by 张飞 on 2019/3/29.
//  Copyright © 2019 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SsidHelper : NSObject
+ (NSString *)fetchSsid;
+ (NSString *)fetchBssid;
+ (NSDictionary *)fetchNetInfo;
@end

NS_ASSUME_NONNULL_END
