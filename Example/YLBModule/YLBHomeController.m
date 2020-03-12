//
//  YLBHomeController.m
//  YLBModule_Example
//
//  Created by yulibo on 2020/3/12.
//  Copyright © 2020 余礼钵. All rights reserved.
//

#import "YLBHomeController.h"
//#import "YLBServices.h"

@interface YLBHomeController ()//<YLBHomeProtocol>

@end

@implementation YLBHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setupSubviews:(void(^)(void))complete {
    NSLog(@"%@!!!",NSStringFromClass([self class]));
    if (complete) {
        complete();
    }
}
@end
