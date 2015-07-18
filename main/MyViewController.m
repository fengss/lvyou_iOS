//
//  MyViewController.m
//
//  Created by coderss on 15/4/4.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "MyViewController.h"
#import "ViewController_1.h"
#import "ViewController_2.h"
#import "ViewController_4.h"
#import "NavViewController.h"
#import "OrderViewController.h"
#define BUTTON_COUNT 3
@interface MyViewController ()
@property(nonatomic,strong) ViewController_1* vc1;
@property(nonatomic,strong) ViewController_2* vc2;
@property(nonatomic,strong) ViewController_4* vc4;



@end

@implementation MyViewController
#pragma mark-创建子控件
//创建子视图
-(void)createViews
{  //创建首页的视图控制器
    ViewController_1 *first=[[ViewController_1 alloc]init];
    self.vc1=first;
   NavViewController *vc1=[[NavViewController alloc]initWithRootViewController:first];
        //创建热门的视图控制器
    vc1.navigationBar.barTintColor=[UIColor colorWithRed:0.2 green:0.3 blue:0.8 alpha:0.2];
    ViewController_2 *second=[[ViewController_2 alloc]init];
    NavViewController *vc2=[[NavViewController alloc]initWithRootViewController:second];
    self.vc2=second;
   // OrderViewController *order=[[OrderViewController alloc]init];
    //创建客服的视图控制器
 //   ViewController_3 *third=[[ViewController_3 alloc]init];
//    NavViewController *vc3=[[NavViewController alloc]initWithRootViewController:third];
//    self.vc3=vc3;
//    //创建我的视图控制器
    ViewController_4 *four=[[ViewController_4 alloc]init];
    NavViewController *vc4=[[NavViewController alloc]initWithRootViewController:four];
    self.vc4=four;
    self.viewControllers=@[vc1,vc2,vc4];
}
/**
 *  创建TabBarItem控件，但是图片要换
 */
-(void)createTarBarItem
{
    NSArray *tabBarName=@[@"首页",@"热门",@"我的"];
    
    for (int i = 0; i < BUTTON_COUNT; i++) {
        NSString *imageName=[NSString stringWithFormat:@"tab_%d.png",i];
       // NSString *selectimage=[NSString stringWithFormat:@"tab_c%d.png",i];
        UITabBarItem *item=self.tabBar.items[i];
        item.title=tabBarName[i];
        item.image=[UIImage imageNamed:imageName];
//        [item setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:imageName]];
        
        }
//    [[UITabBar appearance]setBackgroundImage:[UIImage imageNamed:@"tabbar_bg.png"]];
  //  [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]} forState:UIControlStateNormal];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
    [self createTarBarItem];
        // Do any additional setup after loading the view.
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
