//
//  SearchHelper.h
//  Sample
//
//  Created by 张飞 on 2019/3/30.
//  Copyright © 2019 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchHelper : NSObject
+(void)searchWithCallBack:(void(^)(NSArray *arr))callBack;
@end

NS_ASSUME_NONNULL_END
