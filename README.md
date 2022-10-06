使用YLBModule库：
```ruby
pod 'YLBModule', :git => 'https://github.com/ProBobo/YLBModule.git'
```

YLBModule库地址：[https://github.com/ProBobo/YLBModule](https://github.com/ProBobo/YLBModule)。  

YLBModule库其实分为两部分：模块注册和服务注册。

>模块注册：是为了能在模块中做一些初始化操作。比如一些第三方SDK的初始化。  
服务注册：是为了能调用模块，进行模块通信。

# 一、模块注册

## 模块设置
1、创建模块类文件（.h和.m文件），一般命名规则为模块名称+AppDelegate。这里的模块类为YLBDesignAppDelegate。  

2、模块类添加YLBModuleProtocol协议  
为什么要添加YLBModuleProtocol协议？  
因为添加YLBModuleProtocol协议以后才能实现didFinishLaunchingWithOptions方法。
```
@interface YLBDesignAppDelegate ()<YLBModuleProtocol>

@end
```
3、将当前类注册为模块
```
+ (void)load {
    //注册模块
    [[YLBModuleManager sharedInstance] registerModuleClass:[self class]];
}
```
4、设置模块加载优先级（加载的先后顺序）
```
- (NSInteger)ylb_modulePriority {
    return 1000;//不同的模块返回的值可以不同，数值越小越先加载
}
```
5、实现didFinishLaunchingWithOptions方法
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 可以设置根视图等操作
    return YES;
}
```

## 主工程设置

主工程的AppDelegate继承YLBAppDelegate类，并在didFinishLaunchingWithOptions方法中调用父类的didFinishLaunchingWithOptions方法，即YLBAppDelegate的didFinishLaunchingWithOptions方法。
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //调用 YLBAppDelegate 中 didFinishLaunchingWithOptions 方法从而调用 YLBModuleManager 的 didFinishLaunchingWithOptions 的方法
    //开始加载模块
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}
```
这样模块就可以成功加载。

# 二、服务注册：模块通信

服务注册的功能更为全面。模块注册能实现的效果，服务注册都能做到，模块注册不能实现的功能，服务注册都也能做到。

1、创建服务协议  
服务协议放在单独的Pod库里面，可以参看YLBDesign库（[https://github.com/ProBobo/YLBDesign](https://github.com/ProBobo/YLBDesign)）。
>YLBDesign（[https://github.com/ProBobo/YLBDesign](https://github.com/ProBobo/YLBDesign)）的服务协议放在Pod库YLBDServices中。

以YLBDHome和YLBDServices为例，我们说明一下如何创建一个协议库。  
其中YLBDHome为模块库，YLBDServices为协议库。

1.1、创建协议库
使用pod lib create YLBDServices指令创建YLBDServices库。  
1.2、在协议库YLBDServices中创建协议文件YLBDHomeProtocol。  
1.3、在需要使用协议的模块中添加Pod依赖库YLBDServices。  
在Podfile文件中添加依赖
```
# 架构服务组件：属于YLBModule需要注册的协议
pod 'YLBDServices', :git => 'https://github.com/YuliboTeam/YLBDServices.git'
```
在.podspec文件中添加依赖
```
s.dependency 'YLBDServices' # 用于YLBModule组件的协议注册
```

1.4、注册协议
```
#import <YLBDServices/YLBDHomeProtocol.h>
```
```
+ (void)load {
    //注册服务
    [[YLBServiceManager sharedInstance] registerService:@protocol(YLBDHomeProtocol) implClass:NSClassFromString(@"YLBDHomeController")];
}
```
1.5、通过协议YLBDHomeProtocol获取实现协议的类YLBDHomeController
```
id<YLBDHomeProtocol> homeVC = [[YLBServiceManager sharedInstance] createService:@protocol(YLBDHomeProtocol)];
```

2、模块通信：消息回传/消息回调  
当模块A调用模块B的时候，我们通过registerService方法实现。  
但是出现异步回调时，我们需要在模块B中把消息传送给模块A。

以YLBDDetail和YLBDServices为例，我们说明一下如何实现模块消息回传。

2.1、注册协议
```
[[YLBServiceManager sharedInstance] impService:@protocol(YLBDDetailImpProtocol) target:self];
```
2.2、实现协议
```
#pragma mark - 实现YLBDDetailImpProtocol协议
- (void)ylb_impProtocol {
    NSMutableArray *targetArray = [[YLBServiceManager sharedInstance] impOfProtocol:@protocol(YLBDDetailImpProtocol)];
    for (int i = 0; i < targetArray.count; i++) {
        id<YLBDDetailImpProtocol> ylbdDetail = [targetArray objectAtIndex:i];
        if ([ylbdDetail respondsToSelector:@selector(impFromDetail:)]) {
            
            NSDictionary *dict = @{
                @"moduleName":YLB_PROTECT_STR(self.moduleName),
            };
            
            [ylbdDetail impFromDetail:dict];
        }
    }
}
```

# YLBModule源码说明

**模块注册**  
registerModuleClass方法通过数组moduleArray存储模块类，再对moduleArray通过优先级ylb_modulePriority进行升序排序。

**服务注册：模块通信**  
registerService方法通过可变字典totalServiceDic存储`协议`和`类`的对应关系。  

**服务注册：模块消息回传**。
impService方法通过可变字典totalTargetDic建立包含`类`的数组targetArray和协议的对应关系。
