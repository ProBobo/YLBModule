//
//  YLBTabTwoModule.m
//  YLBModule_Example
//
//  Created by yulibo on 2020/3/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import "YLBTabTwoModule.h"
#import <YLBModuleManager.h>

@interface YLBTabTwoModule ()<YLBModuleProtocol>

@end

@implementation YLBTabTwoModule
+ (void)load {
    [[YLBModuleManager sharedInstance] registerModuleClass:[self class]];
}
- (NSInteger)ylb_modulePriority {
    return 3000;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}
@end
