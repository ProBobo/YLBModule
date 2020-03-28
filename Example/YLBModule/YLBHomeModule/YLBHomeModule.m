//
//  YLBHomeModule.m
//  YLBModule_Example
//
//  Created by yulibo on 2020/3/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import "YLBHomeModule.h"
#import <YLBModuleManager.h>
#import <YLBServiceManager.h>
#import "YLBHomeController.h"

@interface YLBHomeModule ()<YLBModuleProtocol>

//@property (strong, nonatomic) UIWindow *window;

@end

@implementation YLBHomeModule
+ (void)load {
    [[YLBModuleManager sharedInstance] registerModuleClass:[self class]];
}
- (NSInteger)ylb_modulePriority {
    [[YLBServiceManager sharedInstance] registerService:NSProtocolFromString(@"YLBHomeProtocol") implClass:[YLBHomeController class]];
    return 2000;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    YLBHomeController *vc = [YLBHomeController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIWindow *window = [YLBModuleManager sharedInstance].delegate.window;
    window.rootViewController = nav;
    return YES;
}
//- (UIWindow *)window {
////    return [[YLBModuleManager sharedInstance] window];
//    return [YLBModuleManager sharedInstance].delegate.window;
//}
@end
