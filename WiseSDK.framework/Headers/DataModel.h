//
//  DataModel.h
//  wisde
//
//  Created by 张飞 on 2019/3/27.
//  Copyright © 2019 张飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject
@property(nonatomic,copy)NSString *cmdId;
@property(nonatomic,copy)NSArray *values;
@end

NS_ASSUME_NONNULL_END
