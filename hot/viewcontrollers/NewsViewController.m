//
//  NewsViewController.m
//
//  Created by coderss on 15/5/8.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "NewsViewController.h"
#import "HeadFile.h"
#import "loginInview.h"
@interface NewsViewController ()
{
    BOOL _isSelect;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabBarController.tabBar.hidden=YES;
    [self createUI];
    [self createNav];
    self.navigationController.navigationBar.translucent=NO;
   // [self createShareBtn];
    // Do any additional setup after loading the view.
}
-(void)createNav
{
    UINavigationItem *item=self.navigationItem;
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(320 ,0,50, 50)];
    [btn setBackgroundImage:[UIImage imageNamed:@"myfavoritehighlight"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"myfavorite"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=870;
    btn.selected=NO;
    UIBarButtonItem *it=[[UIBarButtonItem alloc]initWithCustomView:btn];
    item.rightBarButtonItem=it;

}
-(void)createUI
{
    UILabel *name=[MyKit createLabel:CGRectMake(0, 0,SCREEN_WIDTH, 60) WithFont:[UIFont systemFontOfSize:15]];
    name.text=self.model.Newtitle;
    name.numberOfLines=0;
     name.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:name];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(5,60, 365, 2)];
    line.backgroundColor=RGBCOLOR(170, 170, 170);
    [self.view addSubview:line];
    UIScrollView *view=[[UIScrollView alloc]initWithFrame:CGRectMake(0,line.frame.size.height+line.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT-80)];
    CGFloat h=[self.model.newsContent boundingRectWithSize:CGSizeMake(300,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;

    UILabel *content=[MyKit createLabel:CGRectMake(20,0, SCREEN_WIDTH-40, h+10) WithFont:[UIFont systemFontOfSize:13]];
    content.text=self.model.newsContent;
    content.numberOfLines=0;
    
    view.contentSize=CGSizeMake(view.frame.size.width, h+10);
    view.showsVerticalScrollIndicator=NO;
    [self.view addSubview:view];
    [view addSubview:content];
}
-(void)createShareBtn
{
//    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, self.view.frame.size.height/2, 97, 90)];
//    [btn setBackgroundImage:[UIImage imageNamed:@"myfavoritehighlight"] forState:UIControlStateSelected];
//    [btn setBackgroundImage:[UIImage imageNamed:@"myfavorite"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
//    btn.tag=870;
//    btn.selected=NO;
//    [self.view addSubview:btn];
//
}
-(void)shareClick:(UIButton *)btn
{
    if(btn.selected)
    {
        btn.selected=NO;
    }
    else
    {
        btn.selected=YES;
    }
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
