//
//  NavViewController.m
//
//  Created by coderss on 15/4/21.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController
#pragma mark-创建自己的导航控制器
- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *bar=self.navigationBar;
    bar.barTintColor=[UIColor colorWithRed:0 green:0.7 blue:0.9 alpha:1];
    bar.barStyle=UIBarStyleBlackTranslucent;    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
