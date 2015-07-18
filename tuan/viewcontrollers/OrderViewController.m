//
//  OrderViewController.m
//
//  Created by coderss on 15/5/7.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "OrderViewController.h"
#import "HeadFile.h"
#import "NewConn.h"
@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSArray *_contant;
    BOOL isClick;

    int _number1;
    int _number2;
}
@property(nonatomic,strong) UserInfo *userModel;
@property(nonatomic,strong) NSMutableArray* userArray;
@property(nonatomic,strong) NSArray* dateArray;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   _userArray =[NSMutableArray array];
    [self loadData];
    self.view.backgroundColor=[UIColor whiteColor];
   
    _contant=@[@"姓名",@"手机号",@"邮箱"];
    isClick=NO;
    [self createCommitButton];
    _number1=1;
    _number2=1;
  
    // Do any additional setup after loading the view.
}
-(void)createTableView
{
    self.navigationController.navigationBar.translucent=NO;
    table=[[UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT-40) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.tableHeaderView=[self createTableHeadView];
    if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
        [table setSeparatorInset:UIEdgeInsetsZero];
    }

    [self.view addSubview:table];
}
-(UIView *)createTableHeadView
{
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    v.backgroundColor=RGBCOLOR(252, 221,188);
    UILabel *l=[MyKit createLabel:CGRectMake(15, 2, 345, 40) WithFont:[UIFont systemFontOfSize:12]];
    l.text=@"请仔细填写订单，我们会提供更好的服务，你的满意就是我们的最大的动力";
    l.numberOfLines=0;
    l.textColor=RGBCOLOR(255, 103, 51);
    [v addSubview:l];
    return v;
}
#pragma mark-tableview的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    return 1;
    else if(section==1)
        return 3;
    else if(section==2)
    {
        if(isClick)
        {
            return self.dateArray.count;
        }
        else
        {
            return 0;
        }
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section==0)
//        return 40;
//    if(indexPath.section==1&&indexPath.row==0)
//        return 20;

    if(indexPath.section==2)
        return 30;
        return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return 0;
    if(section==2)
        return 40;
    if(section==3)
        return 10;
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *str=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]init];
    }
    
    if(indexPath.section==0)
    {
        UILabel *l=[MyKit createLabel:CGRectMake(150, 0,100, 40) WithFont:[UIFont systemFontOfSize:18]];
      l.text=@"上海欢乐谷";
        [cell.contentView addSubview:l];
        
    }
    if(indexPath.section==1)
    {
        
        UILabel *l=[MyKit createLabel:CGRectMake(20, 10, 80, 30) WithFont:[UIFont systemFontOfSize:13]];
        l.text=_contant[indexPath.row];
        [cell.contentView addSubview:l];
        UILabel *name=[MyKit createLabel:CGRectMake(120, 10, 150, 30) WithFont:[UIFont systemFontOfSize:13]];
        name.text=_userArray[indexPath.row];
        [cell.contentView addSubview:name];
    
    }
    else if(indexPath.section==2)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(0, 0, SCREEN_WIDTH, 30);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:self.dateArray[indexPath.row] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:btn];
    }
    else if(indexPath.section==3)
    {
        if(indexPath.row==0)
        {
            [cell.contentView addSubview:[self createPeopleNumWithNameString:@"成 人" WithLTag:100+indexPath.row WithRTag:200+indexPath.row] ];
        }
        else
        {
              [cell.contentView addSubview:[self createPeopleNumWithNameString:@"儿 童" WithLTag:100+indexPath.row WithRTag:200+indexPath.row]];
        }
    }
   else  if(indexPath.section==4)
       [cell.contentView addSubview:[self createTourInfo]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
      return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==1)
        return [self createHeaderViewInSecOne];
    if(section==2)
    {
    return [self createHeadViewInSecTwo];
    }
    else if(section==4)
    {
        return [self createHeadViewInSecThree];
    }
    return nil;
}
#pragma mark-创建头部视图
-(UIView *)createHeaderViewInSecOne
{
   
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH, 30)];
   UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,0.5)];
   line.backgroundColor=RGBCOLOR(220 , 220, 223);
    [v addSubview:line];
    UIImageView *image=[MyKit createImageWithFrame:CGRectMake(10, 5, 20,20) WithImage:[UIImage imageNamed:@"tabbaritem-myplan-unselected"]];
    [v addSubview:image];
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 100, 20)];
    name.font=[UIFont systemFontOfSize:13];
    name.text=@"预定人信息";
    [v addSubview:name];
    v.backgroundColor=[UIColor whiteColor];
    return v;
}
-(UIButton *)createHeadViewInSecTwo
{
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,1)];
    line.backgroundColor=RGBCOLOR(220 , 220, 223);
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(0, 0, SCREEN_WIDTH,30);
    [btn addSubview:line];
    UIImageView *image=[MyKit createImageWithFrame:CGRectMake(10, 10, 20, 20) WithImage:[UIImage imageNamed:@"jschedule-detail"]];
    [btn addSubview:image];

    UILabel *l=[MyKit createLabel:CGRectMake(35, 10, 60, 20) WithFont:[UIFont systemFontOfSize:13]];
    l.text=@"使用日期";
    [btn addSubview:l];
    UILabel *date=[MyKit createLabel:CGRectMake(150, 10, 100, 20) WithFont:[UIFont systemFontOfSize:14]];
    date.text=@"2015-05-09";
    [btn addSubview:date];
    [btn addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor whiteColor]];
    UIImageView *xia=[[UIImageView alloc]initWithFrame:CGRectMake(340, 13, 10, 10)];
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 40,SCREEN_WIDTH ,1)];
    line1.backgroundColor=RGBCOLOR(220 , 220, 223);

    [btn addSubview:xia];
    if(!isClick)
    {
               xia.image=[UIImage imageNamed:@"xia2"];
        [btn addSubview:line1];
    }
    else
    {
        xia.image=[UIImage imageNamed:@"right2"];

    }
    return btn;
}
-(UIView *)createHeadViewInSecThree
{
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH, 30)];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,0.5)];
    line.backgroundColor=RGBCOLOR(220 , 220, 223);
    [v addSubview:line];
    UIImageView *image=[MyKit createImageWithFrame:CGRectMake(10, 5, 20, 20) WithImage:[UIImage imageNamed:@"tabbaritem-myplan-unselected"]];
    [v addSubview:image];
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 100, 20)];
    name.font=[UIFont systemFontOfSize:14];
    name.text=@"游客信息";
    [v addSubview:name];
    UIButton *btn=[MyKit createBtnFrame:CGRectMake(240, 5, 100, 20) title:@"编辑游客信息" target:self action:@selector(editClick:)];
    [btn setTitleColor:RGBCOLOR(255, 103, 51) forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    [v addSubview:btn];
    v.backgroundColor=[UIColor whiteColor];
    return v;
}

#pragma mark-创建cell视图
-(UIView *)createPeopleNumWithNameString:(NSString *)str WithLTag:(NSInteger)ltag WithRTag:(NSInteger)rtag
{
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    v.backgroundColor=[UIColor whiteColor];
    
    UILabel *l=[MyKit createLabel:CGRectMake(10, 10, 80, 15) WithFont:[UIFont systemFontOfSize:14]];
    l.text=str;
    [v addSubview:l];
    UILabel *p=[MyKit createLabel:CGRectMake(10, 28,40, 10) WithFont:[UIFont systemFontOfSize:12]];
    p.text=@"单价￥";
    p.textColor=RGBCOLOR(170, 170,170);
    [v addSubview:p];
    UILabel *r=[MyKit createLabel:CGRectMake(52, 28, 60, 10) WithFont:[UIFont systemFontOfSize:12]];
    r.tag=ltag-100+400;
    if(r.tag==400)
     r.text=self.model.AdultMoney;
    else
        r.text=self.model.ChildMoney;
    r.textColor=RGBCOLOR(170, 170,170);
    [v addSubview:r];
    UIButton *left=[UIButton buttonWithType:UIButtonTypeCustom];
    [left setBackgroundImage:[UIImage imageNamed:@"map_minus"] forState:UIControlStateNormal];
    left.frame=CGRectMake(250, 10, 25, 25);
    left.tag=ltag;
    [left addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:left];
    UILabel *num=[MyKit createLabel:CGRectMake(280, 10, 13, 25) WithFont:[UIFont systemFontOfSize:14]];
    num.tag=300+ltag-100;
    if(num.tag==300)
    num.text=[NSString stringWithFormat:@"%d",_number1];
    else
        num.text=[NSString stringWithFormat:@"%d",_number2];
    [v addSubview:num];
    UIButton *right=[UIButton buttonWithType:UIButtonTypeCustom];
    right.frame=CGRectMake(295, 10, 25, 25);
    [right setImage:[UIImage imageNamed:@"map_plus"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    right.tag=rtag;
    [v addSubview:right];
    return v;
}
-(UIView *)createTourInfo
{
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10, 5, 3, 25)];
    line.backgroundColor=RGBCOLOR(255, 103, 51);
    [v addSubview:line];
    UILabel *name=[MyKit createLabel:CGRectMake(22, 5, 80, 15) WithFont:[UIFont systemFontOfSize:13]];
    name.text=@"程伟d";
    [v addSubview:name];
    UILabel *hu=[MyKit createLabel:CGRectMake(22, 23, 200, 10) WithFont:[UIFont systemFontOfSize:12]];
    hu.text=@"342531199310080279";
    hu.textColor=RGBCOLOR(170, 170, 170);
    [v addSubview:hu];
    return v;
}
#pragma mark-创建提交订单
-(void)createCommitButton
{
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-64-40,SCREEN_WIDTH,40)];
    image.image=[UIImage imageNamed:@"navigationbar"];
    image.userInteractionEnabled=YES;
    [self.view addSubview:image];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 20)];
    label.text=@"总价";
    label.font=[UIFont systemFontOfSize:12];
    [image addSubview:label];
    UILabel *p=[MyKit createLabel:CGRectMake(50, 10, 50, 20) WithFont:[UIFont systemFontOfSize:12]];
    p.text=@"2561";
    [image addSubview:p];
    
    UIButton *btn=[MyKit createBtnFrame:CGRectMake(SCREEN_WIDTH-70, 5, 60, 30) title:@"提交" target:self action:@selector(commitcClick:)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius=5;
    btn.layer.cornerRadius=YES;
    btn.titleLabel.font=[UIFont systemFontOfSize:11];
    [btn setBackgroundColor:RGBCOLOR(255,103,51)];
    [image addSubview:btn];

}
#pragma mark-BUTTON的点击事件
-(void)dateClick:(UIButton *)btn
{
    
    
   if(isClick)
       isClick=NO;
    else
        isClick=YES;
    [table reloadData];
}
-(void)leftBtnClick:(UIButton *)left
{
    UILabel *l=(UILabel *)[self.view viewWithTag:left.tag-100+300];
    if(l.tag==300)
    {
        if(_number1==0)
            return;
      l.text=[NSString stringWithFormat:@"%d",_number1];

     _number1--;
    }
    else
    {
        if(_number2==0)
            return;
        l.text=[NSString stringWithFormat:@"%d",_number2];
        
        _number2--;

    }
       [table reloadData];
    
}
-(void)rightBtnClick:(UIButton *)right
{
    UILabel *l=(UILabel *)[self.view viewWithTag:right.tag-200+300];
    if(l.tag==300)
    {
        if(_number1==0)
            return;
        l.text=[NSString stringWithFormat:@"%d",_number1];
        
        _number1++;
    }
    else
    {
        if(_number2==0)
            return;
        l.text=[NSString stringWithFormat:@"%d",_number2];
        
        _number2++;
        
    }
    [table reloadData];
}
-(void)editClick:(UIButton *)btn
{
    NewConn *new=[[NewConn alloc]init];
    [self.navigationController pushViewController:new animated:YES];
    new.adultNum=_number1;
    new.childNum=_number2;
    new.UserId=self.UserId;
}
    -(void)commitcClick:(UIButton *)btn
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData
{
    
    self.dateArray=[self.model.Waydate componentsSeparatedByString:@"\n"];
      for(NSString *str in self.dateArray)
          NSLog(@"str=%@",str);
    
    self.userModel=[[UserInfo alloc]init];
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    NSString *url=[NSString stringWithFormat:USERINFOURL,self.UserId];
    [delegate.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsdata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic =[NSDictionary dictionaryWithDictionary:jsdata];
        [self.userModel setValuesForKeysWithDictionary:dic];
        [_userArray addObject:self.userModel.UserName];
        if(self.userModel.phoneNum==nil)
        {
            self.userModel.phoneNum=@"";
        }
        [_userArray addObject:self.userModel.phoneNum];
        [_userArray addObject:self.userModel.Email];
        [self createTableView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
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
