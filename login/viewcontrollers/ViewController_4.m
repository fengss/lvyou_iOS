//
//  ViewController_4.m
//
//  Created by coderss on 15/4/4.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "ViewController_4.h"
#import "HeadFile.h"
#define IMGEVIEWHIGH 100
#import "MyTableViewCell.h"
#import "LoginInViewController.h"
#import "ResignView.h"
#import "UserInfoController.h"
#import "UserInfo.h"
#import "PhotoShow.h"
@interface ViewController_4 ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    BOOL isFresh;
}
@property(nonatomic,strong) UITableView* table;
@property(nonatomic,strong) NSArray *name;
@property(nonatomic,strong) NSArray* head;
@property(nonatomic,strong) UIView* gv;
@property(nonatomic,strong) UIImageView* ima;
@property(nonatomic,strong) UserInfo* model;
@property(nonatomic,strong) UIImage* headImage;
@property(nonatomic,strong) NSMutableData* imageData;
@property(nonatomic,strong) NSArray* imageArray;


@end
//UITableViewCell
@implementation ViewController_4
  
- (void)viewDidLoad {
    NSLog(@"先进入这里");
    [super viewDidLoad];
     self.view.backgroundColor=RGBCOLOR(234, 235, 242);
     self.title=@"我的";
    self.model=[[UserInfo alloc]init];
self.navigationController.navigationBar.translucent=NO;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];;
    self.name=@[@[@"我的订单",@"清除缓存"],@[@"我的照片",@"我的评论"],@[@"常用游客信息",@"我的信息",@"修改密码"]];
    [self createimageview];
     [self createtable];
    self.imageData=[NSMutableData data];
    self.headImage=nil;
    isFresh=YES;
}


#pragma mark-创建图画
-(void)createimageview
{
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,IMGEVIEWHIGH)];
    image.image=[UIImage imageNamed:@"2.jpg"];
    image.userInteractionEnabled=YES;
        self.ima=image;
    [self.view addSubview:image];
   

}
-(void)createOldImage
{
    NSArray *array=@[@"登录",@"注册"];

    NSArray *color=@[RGBCOLOR(350, 210, 213),RGBCOLOR(250, 360, 214)];
    CGFloat x=100;
    CGFloat y=40;
    CGFloat space=50;
    CGFloat hight=40;
    CGFloat wight=70;
    for(int i=0;i<2;i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
                       btn.frame=CGRectMake(x+i*(wight+space),y,wight   ,hight);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:color[i]];
        [self.ima addSubview:btn];
        btn.layer.cornerRadius=5;
        btn.tag=100+i;
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.masksToBounds=YES;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
     }
    }
-(void)btnclick:(UIButton *)btn
{
    if(btn.tag==100)
    {
       
    
  [UIView animateWithDuration:0.3 animations:^{
      LoginInViewController *login=[[LoginInViewController alloc]init];
      login.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
      [self presentViewController:login animated:YES completion:nil];

  }];
   }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
           
            
        } completion:^(BOOL finished) {
            
            ResignView *resign=[[ResignView alloc]init];
            resign.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
            [self presentViewController:resign animated:YES completion:nil];
        }];

    }
}
#pragma mark-创建表格
-(void)createtable
{
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0,IMGEVIEWHIGH, SCREEN_WIDTH, SCREEN_HEIGHT-IMGEVIEWHIGH-64-49) style:UITableViewStyleGrouped];
    table.bounces=NO;
    table.dataSource=self;
    table.delegate=self;
    [self.view addSubview:table];
   // table.backgroundColor=[UIColor yellowColor];
  //  table.separatorStyle= UITableViewCellSeparatorStyleNone;
    self.table=table;
}
#pragma mark-tableview的协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==2)
    return 3;
    return 2;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"cellid";
   MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];

    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTableViewCell" owner:self options:nil]lastObject];
    }
    if(indexPath.section==0&indexPath.row==1)
    {
        int cacheNumber = (int)[[SDImageCache sharedImageCache] getSize];
        NSString *cacheStr = [self cacheNumber:cacheNumber];
        UILabel *cacheL = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 15)];
        cacheL.tag = 190;
        cacheL.text = cacheStr;
        cacheL.font=[UIFont systemFontOfSize:15];
        cacheL.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:cacheL];

    }
    cell.secname.text=[self.name[indexPath.section] objectAtIndex:indexPath.row];
    cell.backgroundColor=RGBCOLOR(234, 235, 242);
    cell.headimage.image= [UIImage imageNamed:@"write.png"];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark-当用户登录成功时，界面要修改
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"进入到appear里面");
    self.tabBarController.tabBar.hidden=NO;
  NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    NSLog(@"loginstr=%@",str);
    if(![str isEqualToString:@"0"])
    {
        for(int i=100;i<102;i++)
        {
            UIButton *btn=(UIButton *)[self.view viewWithTag:i];
            [btn removeFromSuperview];
            btn=nil;
        }
        [self createNewImage];
    }
    else
    {
          [self createOldImage];
    }
    if(isFresh)
    [self loadUserInfoData];
    
    isFresh=YES;
}
-(void)createNewImage
{
    UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(60, 20, 60, 60)];
    imagev.image=[UIImage imageNamed:@"view_4.jpg"];
    imagev.tag=213;
    imagev.layer.cornerRadius=30;
    imagev.layer.masksToBounds=YES;
    [self.ima addSubview:imagev];
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(145,35, 100, 30)];
    NSLog(@"self.model.username=%@",self.model.UserName);
    name.text=self.model.UserName;
    name.font=[UIFont systemFontOfSize:20];
    name.textColor=[UIColor whiteColor];
    [self.ima addSubview:name];
    name.tag=214;
    CGFloat y=SCREEN_HEIGHT-49-110;
    UIButton *btn= [[UIButton  alloc]initWithFrame:CGRectMake(30,y,SCREEN_WIDTH-60,30)];
    [btn setTitle:@"安全退出登录" forState:UIControlStateNormal];
   // btn.backgroundColor=RGBCOLOR(263, 125, 190);
    btn.layer.cornerRadius=8;
    btn.layer.masksToBounds=YES;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(quitclick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=215;
    btn.layer.borderColor=[UIColor redColor].CGColor;
    btn.layer.borderWidth=1;
    [self.view addSubview:btn];
}
-(void)quitclick:(UIButton *)btn
{
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    UIImageView *image=(UIImageView *)[self.view viewWithTag:213];
  
    [image removeFromSuperview];
      image=nil;
    UILabel *label=(UILabel*)[self.view viewWithTag:214];
     [label removeFromSuperview];
    label=nil;
    UIButton *b=(UIButton *)[self.view viewWithTag:215];
   
    [b removeFromSuperview];
   // NSLog(@"btn.tag=%ld",btn.tag);
     b=nil;
    [self createOldImage];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *str =[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    NSLog(@"num=%@",str);
    NSLog(@"%d",[str isEqualToString:@"0"]);
    if(indexPath.section==0&indexPath.row==1)
    {
        [[SDImageCache sharedImageCache] clearDisk];
        //清除缓存
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell viewWithTag:190];
        label.text = @"0 B";
        isFresh=NO;
    }
   else
   {
       if([ str isEqualToString:@"0"])
    {
        LoginInViewController *login=[[LoginInViewController alloc]init];
        login.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        [self presentViewController:login animated:YES completion:nil];
        

    }
    else
    {
       if(indexPath.section==2&&indexPath.row==1)
       {
           UserInfoController *user=[[UserInfoController alloc]init];
           user.model=self.model;
           if(self.model.headImage)
           user.headimage=self.headImage;
           else
               user.headimage=nil;
           NSLog(@"user.headimage=%@",self.headImage);
           [self.navigationController pushViewController:user animated:YES];
       }
        
        if(indexPath.section==1&&indexPath.row==0)
        {
            PhotoShow *photo=[[PhotoShow alloc]init];
            photo.UserId=str;
            photo.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:photo animated:YES];
            isFresh=NO;
        }
       
    }
   }
}
#pragma mark-解决了view出现button创造两次的问题了
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden=YES;
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if(![str isEqualToString:@"0"])
    {
        UIImageView *image=(UIImageView *)[self.view viewWithTag:213];
        
        [image removeFromSuperview];
        image=nil;
        UILabel *label=(UILabel*)[self.view viewWithTag:214];
        [label removeFromSuperview];
        label=nil;
        UIButton *b=(UIButton *)[self.view viewWithTag:215];
        
        [b removeFromSuperview];
        b=nil;

    }
    else
    {
        for(int i=100;i<102;i++)
        {
            UIButton *btn=(UIButton *)[self.view viewWithTag:i];
            [btn removeFromSuperview];
            btn=nil;
        }

        
    }
    self.tabBarController.tabBar.hidden=NO;
}
-(void)loadUserInfoData
{
       NSString *useid=[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if([useid isEqualToString:@"0"])
    {
        return;
        
    }

[self createFresh];
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *url=[NSString stringWithFormat:USERINFOURL,useid];
    NSLog(@"url=%@",url);
    [delegate.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:jsondata];
       // NSLog(@"dic %@",dic);
        [self.model setValuesForKeysWithDictionary:dic];
        NSLog(@"%@",self.model);
        UIView *vc=(UIView *)[self.navigationController.view viewWithTag:900];
        [ProgressHUD hideOnView:vc];
        [vc removeFromSuperview];
        vc=nil;

        UILabel *name=(UILabel *)[self.view viewWithTag:214];
        name.text=self.model.UserName;
        NSLog(@"self.model.headimage=%@",self.model.headImage);
         if(!self.model.headImage)
         {
            self.headImage=[UIImage imageNamed:@"view_4.jpg"];
            // v.image=self.headImage;
         }
        else
        {
        NSString *imageurl=[NSString stringWithFormat:IMAGEYUMING,self.model.headImage];
       /*NSLog(@"imageurl=%@",imageurl);
            v.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageurl]]];
        self.headImage=v.image;
            NSLog(@"v.image=%@",v.image);
        */
            
            
            //这样做是因为图片太大，是异步下载照片，本来应该同步下载的。
              NSURL *url=[NSURL URLWithString:imageurl];
             NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
             NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        UIView *vc=(UIView *)[self.navigationController.view viewWithTag:900];
        [ProgressHUD hideOnView:vc];
        [vc removeFromSuperview];
        vc=nil;

    }];
}
/* NSURL *url=[NSURL URLWithString:SUREURL];
 NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
 NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
 
 }
 */
 #pragma mark－图片的异步下载 解决屏幕半天出来的原因
 - (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
 {
 NSLog(@"error = %@", [error localizedDescription]);
 }
 
 // 收到服务器返回的应答包时调用的方法
 - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
 {
 NSLog(@"response = %@", response);
 // 清空原来的数据
     [self.imageData setLength:0];
    // self.headImage=nil;
 } //[self.headImage setLength:0];
 
 
 // 收到服务器返回的数据时调用的方法
 // 如果下载的资源比较大，这个资源服务器会将资源分多次发送回来
 - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
 {
 NSLog(@"收到服务器返回的数据");
 // 保存收到的数据
 [self.imageData appendData:data];
 }
 
 // 数据下载完成时调用的方法
 - (void)connectionDidFinishLoading:(NSURLConnection *)connection
 {
      NSLog(@"数据下载已完成");
     self.headImage=[UIImage imageWithData:self.imageData];
     UIImageView *v=(UIImageView *)[self.view viewWithTag:213];
     v.image=self.headImage;
 }

-(void)createFresh
{
    UIView *ve=[[UIView alloc]initWithFrame:self.navigationController.view.frame];
    ve.backgroundColor=[UIColor grayColor];
    ve.tag=900;
    [self.navigationController.view addSubview:ve];
    [ProgressHUD showOnView:ve];
}
#pragma mark - 计算缓存  转化单位
- (NSString *)cacheNumber:(int)cacheNumber{
    if (cacheNumber <= 1024) {
        return [NSString stringWithFormat:@"%d B",cacheNumber];
    }else if (cacheNumber > 1024  && cacheNumber <= (1024 * 1024)){
        return [NSString stringWithFormat:@"%.1f KB",cacheNumber/(1024 * 1.0)];
    }else if(cacheNumber > (1024 * 1024) && cacheNumber <= (1024 * 1024 *1024)){
        return [NSString stringWithFormat:@"%.1f M",cacheNumber/(1024.0*1024.0*1.0)];
    }else{
        return [NSString stringWithFormat:@"%.1f G",cacheNumber/(1024*1024*1024 *1.0)];
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
