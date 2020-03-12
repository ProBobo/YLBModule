//
//  YLBServiceManager.m
//  YLBModule_Example
//
//  Created by yulibo on 2020/3/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import "YLBServiceManager.h"

@interface YLBServiceManager ()
@property (nonatomic, strong) NSMutableDictionary *totalServiceDic;
@property (nonatomic, strong) NSRecursiveLock *lock;
@end

static NSString * const kService = @"service";
static NSString * const kImpl = @"impl";

@implementation YLBServiceManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static YLBServiceManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

#pragma mark - 初始化
- (NSRecursiveLock *)lock {
    if (!_lock) {
        _lock = [[NSRecursiveLock alloc] init];
    }
    return _lock;
}
- (NSMutableDictionary *)totalServiceDic {
    if (!_totalServiceDic) {
        _totalServiceDic = [NSMutableDictionary dictionary];
    }
    return _totalServiceDic;
}

- (NSDictionary *)transcriptServiceDic {
    [self.lock lock];
    NSDictionary *dic = [self.totalServiceDic copy];
    [self.lock unlock];
    return dic;
}

- (void)registerService:(Protocol *)service implClass:(Class)implClass {
    //参数不能为空
    if (!service || !implClass) {
        return;
    }
    //没有实现协议
//    if (![implClass conformsToProtocol:service]) {
//        return;
//    }
    
    if ([self isExistService:service]) {
        //说明已经注册过协议
        return;
    }
    
    NSString *key = NSStringFromProtocol(service);
    NSString *value = NSStringFromClass(implClass);
    if (key.length > 0 && value.length > 0) {
        [self.lock lock];
        [self.totalServiceDic addEntriesFromDictionary:@{key:value}];
        [self.lock unlock];
    }
}

- (id)createService:(Protocol *)service {
    if (!service) {
        return nil;
    }
    
    id implInstance = nil;
    Class implClass = [self getImplClass:service];
        
    if ([[implClass class] respondsToSelector:@selector(sharedInstance)]) {
        implInstance = [[implClass class] sharedInstance];
    }
    else {
        implInstance = [[implClass alloc] init];
    }
    return implInstance;
}

- (BOOL)isExistService:(Protocol *)service {
    NSString *key = NSStringFromProtocol(service);
    NSString *implName = [[self transcriptServiceDic] objectForKey:key];
    if (implName.length > 0) {
        return YES;
    }
    return NO;
}

- (Class)getImplClass:(Protocol *)service {
    NSString *key = NSStringFromProtocol(service);
    NSString *implName = [[self transcriptServiceDic] objectForKey:key];
    if (implName.length > 0) {
        return NSClassFromString(implName);
    }
    return nil;
}

@end
