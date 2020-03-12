//
//  YLBViewController.m
//  YLBModule
//
//  Created by ProBobo on 03/11/2020.
//  Copyright (c) 2020 ProBobo. All rights reserved.
//

#import "YLBViewController.h"
#import "YLBServices.h"
#import <YLBServiceManager.h>

@interface YLBViewController ()

@end

@implementation YLBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    id<YLBHomeProtocol>homeController = [[YLBServiceManager sharedInstance] createService:@protocol(YLBHomeProtocol)];
    __weak __typeof(self)weakSelf = self;
    [homeController setupSubviews:^{
        NSLog(@"%@!!!",NSStringFromClass([weakSelf class]));
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
