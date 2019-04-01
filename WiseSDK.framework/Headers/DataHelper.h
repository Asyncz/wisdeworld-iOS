//
//  DataHelper.h
//  wisde
//
//  Created by 张飞 on 2019/3/27.
//  Copyright © 2019 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataHelper : NSObject
+(DataModel *)readData:(NSString *)data;
+(NSString *)creatDataWithCode:(NSString *)code values:(NSArray *)values;
@end

NS_ASSUME_NONNULL_END
