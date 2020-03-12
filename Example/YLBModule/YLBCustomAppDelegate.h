//
//  YLBCustomAppDelegate.h
//  YLBModule_Example
//
//  Created by yulibo on 2020/3/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import <YLBAppDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBCustomAppDelegate : YLBAppDelegate<UIApplicationDelegate,UNUserNotificationCenterDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

NS_ASSUME_NONNULL_END
