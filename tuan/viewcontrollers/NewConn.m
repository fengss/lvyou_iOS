//
//  NewConn.m
//
//  Created by coderss on 15/5/9.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "NewConn.h"
#import "HeadFile.h"
#import "people.h"
#import "PepoleViewController.h"
#import "ConnModel.h"
@interface NewConn ()
{
int newChild;
int newAd;
    NSMutableArray *_dataArray;
    UIButton *addBtn;
}
@end

@implementation NewConn

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    newChild=0;
    newAd=0;
    [self createButoont];
    [self createTint];
    _dataArray=[NSMutableArray array];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
-(void)createButoont
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(10, 20, SCREEN_WIDTH-20, 30);
    [btn setTitle:@"新增旅客" forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(255, 103, 51) forState:UIControlStateNormal];
    btn.layer.cornerRadius=5;
    btn.layer.masksToBounds=YES;
    btn.layer.borderWidth=1;
    btn.layer.borderColor=RGBCOLOR(255, 103, 51).CGColor;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    addBtn=btn;
}
-(void)createTint
{
    UIView *v=[MyKit createUIView:CGRectMake(0,SCREEN_HEIGHT-40-64, SCREEN_WIDTH, 40) WithColor:[UIColor blackColor ]];
    v.alpha=0.6;
    [self.view addSubview:v];
    NSMutableString *str=[NSMutableString string];
    if(self.adultNum-newAd >0)
    {
        [str appendFormat:@"您还需要选择%d位成人",self.adultNum-newAd ];
        if(self.childNum-newChild>0)
            [str appendFormat:@",选择%d位儿童",self.childNum-newChild];
        
    }
    else
    {
        if(newChild>0)
            [str appendFormat:@",您还需要选择%d位儿童",self.childNum-newChild];
        else
        {
            
        }
    }
    NSLog(@"str=%@",str);
    CGFloat w=[str  boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
    
    UILabel *l=[MyKit createLabel:CGRectMake(SCREEN_WIDTH-80-w-5, 8, w+5, 20) WithFont:[UIFont systemFontOfSize:13]];
    l.textColor=[UIColor whiteColor];
    l.text=str;
    l.backgroundColor=[UIColor redColor];
    [v addSubview:l];
}
-(void)addClick:(UIButton *)btn
{
    PepoleViewController *p=[[PepoleViewController alloc]init];
    p.UserId=self.UserId;
    [self.navigationController pushViewController:p animated:YES];
}
-(void)loadData
{
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *url=[NSString stringWithFormat:READCONNURL,self.UserId];
    [delegate.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=[NSArray arrayWithArray:jsondata];
        for(int i=0;i<array.count;i++)
        {
            NSDictionary *dic=array[i];
            ConnModel *model=[[ConnModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [self refreshData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error=%@",error);
    }];
}
-(void)refreshData
{
    CGFloat y=addBtn.frame.size.height+addBtn.frame.origin.y+20;
    CGFloat space=20;
    CGFloat h=55;
    for(int i=0;i<_dataArray.count;i++)
    {
        people *p=[[[NSBundle mainBundle]loadNibNamed:@"people" owner:self options:nil]lastObject];
        p.tag=500+i;
        p.frame=CGRectMake(0, y+(space+h)*i, SCREEN_WIDTH, h);
        ConnModel *model=[_dataArray objectAtIndex:i];
        [p configUI:model];
        p.selectBtn.tag=145+i;
        [self.view addSubview:p];
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
