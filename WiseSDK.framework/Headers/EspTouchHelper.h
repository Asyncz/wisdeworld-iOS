//
//  EspTouchHelper.h
//  Sample
//
//  Created by 张飞 on 2019/3/30.
//  Copyright © 2019 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ESPTouchHelperDelegate <NSObject>
- (void)espTouchFailed;
- (void)espTouchCanceled;
- (void)espTouchSuccessedWithResults:(NSArray *)arr;
- (void)espTouchDidAddWithResult:(NSDictionary *)dic;
@end

@interface EspTouchHelper : NSObject
+(void)configWithSsid:(NSString *)apSsid
                bSsid:(NSString *)apBssid
                  pwd:(NSString *)apPwd
               devPwd:(NSString *)devPwd
                count:(NSString *)count
             delegate:(NSObject<ESPTouchHelperDelegate> *)delegate;
+(void)cancel;
@end

NS_ASSUME_NONNULL_END
