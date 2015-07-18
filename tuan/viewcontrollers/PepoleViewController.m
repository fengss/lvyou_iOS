//
//  PepoleViewController.m
//
//  Created by coderss on 15/5/9.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "PepoleViewController.h"
#import"newConnectPeople.h"
#import "peopleView.h"
#import "HeadFile.h"
@interface PepoleViewController ()<peopleViewDelegate>

@end

@implementation PepoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     peopleView *new=[[[NSBundle mainBundle]loadNibNamed:@"peopleView" owner:self options:nil]firstObject];
    self.navigationController.navigationBar.translucent=NO;
    new.frame=CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT );
    new.delegate=self;
    new.UserId=self.UserId;
    [self.view addSubview:new];
    self.title=@"新增联系人";
   
        // Do any additional setup after loading the view.
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
