//
//  YLBModuleProtocol.h
//  YLBModule_Example
//
//  Created by yulibo on 2020/3/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLBApplicationDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@protocol YLBModuleProtocol <NSObject,YLBApplicationDelegate>
@optional
//优先级
- (NSInteger)ylb_modulePriority;


@end

NS_ASSUME_NONNULL_END
