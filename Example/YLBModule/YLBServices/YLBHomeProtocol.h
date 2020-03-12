//
//  YLBHomeProtocol.h
//  YLBModule_Example
//
//  Created by yulibo on 2020/3/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YLBHomeProtocol <NSObject>
@optional
- (void)setupSubviews:(void(^)(void))complete;
@end

NS_ASSUME_NONNULL_END
