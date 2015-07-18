//
//  LoginInViewController.m
//
//  Created by coderss on 15/4/28.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "LoginInViewController.h"
#import "loginInview.h"
#import "HeadFile.h"
#import "ResignView.h"
#import "UserInfo.h"
@interface LoginInViewController ()<loginInviewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UserInfo* model;

@end

@implementation LoginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    loginInview *view= [[[NSBundle mainBundle]loadNibNamed:@"loginInview" owner:self options:nil]lastObject];
    view.frame=CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:view];
    view.name.delegate=self;
    view.secret.delegate=self;
     view.delegate=self;
    // Do any additional setup after loading the view.
}
#pragma mark-loginInviewDelegate代理方法
-(void)loginclose
{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"123456");
    
    
    
}
-(void)presentResign
{
    ResignView *resign=[[ResignView alloc]init];
//    self presentViewController:resign animated:YES completion:
    [self presentViewController:resign animated:YES completion:nil
    ];
}
#pragma mark-textfiled
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewWilldisapper");;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
    if(![str isEqualToString:@"0"])
    {
        [self dismissViewControllerAnimated:NO completion:nil];
    }

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
