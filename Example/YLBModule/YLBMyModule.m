//
//  YLBMyModule.m
//  YLBModule_Example
//
//  Created by yulibo on 2020/3/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import "YLBMyModule.h"
#import <YLBModuleManager.h>

@interface YLBMyModule ()<YLBModuleProtocol>

@end

@implementation YLBMyModule

+ (void)load {
    [[YLBModuleManager sharedInstance] registerModuleClass:[self class]];
}
- (NSInteger)ylb_modulePriority {
    return 5000;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

@end
