//
//  view_hotol.m
//
//  Created by coderss on 15/4/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "view_hotol.h"
#import "appearHotol.h"
#import "hotolView.h"
#import "HeadFile.h"
#define NAVBARHIGHT 49
#define TABLEHIGHT 540
@interface view_hotol ()
@property(nonatomic,strong) NSArray* LabelName;
@property(nonatomic,strong) NSMutableArray* textFieldArray;
@property(nonatomic,strong) NSMutableArray* resultArray;

@end
@implementation view_hotol
//创建自己的导航栏
-(void)MyNavBar
{
    
    UINavigationItem *item=self.navigationItem;
   item.hidesBackButton=NO;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake( 100,20,100,45)];
    label.text=@"酒店搜索";
    label.textColor=[UIColor blueColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:18];
    item.titleView=label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textFieldArray=[[NSMutableArray alloc]init];
    self.LabelName=@[@"目的地",@"入住日期",@"离开日期",@"酒店名",@"价格"];
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    image1.image=[UIImage imageNamed:@"hotol2.jpg"];
    [self.view addSubview:image1];
    hotolView *view=[[[NSBundle mainBundle]loadNibNamed:@"hotolView" owner:self options:nil]lastObject];
       view.block=^(NSMutableDictionary *dic){
           appearHotol *app=[[appearHotol alloc]init];
           app.dic=dic;
           self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:app animated:YES];
    };
    view.frame=CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [self.view addSubview:view];
    [self.tabBarController.tabBar setHidden:YES];
    [self MyNavBar];
        // Do any additional setup after loading the view.
}


@end
