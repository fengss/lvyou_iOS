//
//  UserInfoController.m
//
//  Created by coderss on 15/4/30.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "UserInfoController.h"
#import "HeadFile.h"

@interface UserInfoController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isEdit;
}
@property(nonatomic,strong) UITableView* table;
@property(nonatomic,strong) NSArray* sexArray;
@property(nonatomic,strong) NSString* sexString;
@property(nonatomic,strong) NSString* dateString;
@property(nonatomic,strong) NSArray* nameLabel;
@property(nonatomic,strong) NSMutableArray* uInfo;
@property(nonatomic,strong) NSMutableDictionary* userDic;
@property(nonatomic,strong) NSArray* dicArray;
@property(nonatomic,strong) UIImage* userImage;

@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    NSLog(@"userid=%@",self.UserId);
    self.title=@"个人资料";
   
    [self createTable];
    isEdit=NO;
  
    self.sexArray=@[@"男",@"女"];
    self.nameLabel=@[@"手机号",@"邮箱",@"真实姓名",@"证件号",@"地址",@"性别",@"出生年月"];
    self.tabBarController.tabBar.hidden=YES;
    [self createNavBar];
    self.userDic=[NSMutableDictionary dictionary];
    self.dicArray=@[@"phoneNum",@"Email",@"realName",@"cardId",@"adress"];
    // Do any additional setup after loading the view.
    NSLog(@"headimage=%@",self.headimage);
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
  
    UIButton *b=(UIButton *)[self.view viewWithTag:800];
    if(self.headimage)
    {
    [b setBackgroundImage: self.headimage forState:UIControlStateNormal];
    }
    else
    {
        [b setBackgroundImage: [UIImage imageNamed:@"view_4.jpg" ]forState:UIControlStateNormal];
    }
    b.userInteractionEnabled=NO;
    

    self.uInfo=[[NSMutableArray alloc]initWithCapacity:0];
    NSLog(@"%@",self.model.Email);
       // [self.uInfo addObjectsFromArray:@[ self.model.phoneNum,self.model.Email,self.model.realName,self.model.cardId,self.model.adress]];
     if(self.model.phoneNum==nil)
     {
         self.model.phoneNum=@"";
     }
    if(self.model.Email==nil)
    {
        self.model.Email=@"";
    }
    if(self.model.realName==nil)
    {
        self.model.realName=@"";
    }
    if(self.model.adress==nil)
    {
        self.model.adress=@"";
    }
    if(self.model.cardId==nil)
    {
        self.model.cardId=@"";
    }
    if(self.model.sex==nil)
    {
        self.model.sex=@"";
    }
    if(self.model.birthday==nil)
    {
        self.model.birthday=@"";
    }
    self.sexString=self.model.sex;
    self.dateString=self.model.birthday;
    [self.uInfo addObject:self.model.phoneNum];
    [self.uInfo addObject:self.model.Email];
    [self.uInfo addObject:self.model.realName];
    [self.uInfo addObject:self.model.cardId];
    [self.uInfo addObject:self.model.adress];
    

    NSLog(@"id=%@",self.model.UserId);
}
#pragma mark-创建tabel
-(void)createTable
{
    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.table.dataSource=self;
    self.table.delegate=self;
    self.table.tag=105;
    [self.view addSubview:self.table];
    [self createHeadView];
    [self createFootView];
}

#pragma mark-创建头部视图
-(void)createHeadView
{
    UIImageView *image=[MyKit createImageWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) WithImage:[UIImage imageNamed:@"2.jpg"]];
    image.userInteractionEnabled=YES;
    //UIButton *btn=[MyKit createBtnFrame:CGRectMake(30, 15, 60, 60) title:nil target:self action:@selector(headImageClick:) ];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(30, 15, 60, 60);
    [btn addTarget:self action:@selector(headImageClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=800;
    if(self.headimage)
    {
        [btn setBackgroundImage: self.headimage forState:UIControlStateNormal];
    }
    else
    {
        [btn setBackgroundImage: [UIImage imageNamed:@"view_4.jpg" ]forState:UIControlStateNormal];
    }
    
    btn.layer.cornerRadius=30;
    btn.layer.masksToBounds=YES;
    [image addSubview:btn];
    UILabel *name=[MyKit createLabel:CGRectMake(100, 25, 100, 20) WithFont:[UIFont systemFontOfSize:20]];
    name.text=self.model.UserName;
    name.textColor=[UIColor whiteColor];
    [image addSubview:name];
    
    self.table.tableHeaderView=image;
    
}
//创建尾部视图
-(void)createFootView
{
    UILabel *label=[MyKit createLabel:CGRectMake(10,30, SCREEN_WIDTH-50, 35) WithFont:[UIFont systemFontOfSize:11]];
    label.text=@"提示：您的资料默认保存为订单联系人信息，请您完整如实填写，避免资料不实带来的不便";
    label.textColor=RGBCOLOR(245, 149, 59);
    label.numberOfLines=0;
    self.table.tableFooterView=label;
}

#pragma mark-创建navbar
-(void)createNavBar
{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.translucent=NO;
    UIButton *saveBtn=[MyKit createBtnFrame:CGRectMake(10, 10, 75, 20) title:@"编辑" target:self action:@selector(saveCilck:)];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem=item;
    saveBtn.tag=216;
    //saveBtn setBackgroundImage:[UIImage imageNamed:] forState:<#(UIControlState)#>
}
#pragma mark-保存按钮的点击事件
-(void)saveCilck:(UIButton *)btn
{
   // NSLog(@"%@",btn.titleLabel.text);
    
    if([btn.titleLabel.text isEqualToString:@"编辑"])
    {
        
       // NSLog(@"cell进入编辑");
        isEdit=YES;
        UIButton *b=(UIButton *)[self.view viewWithTag:800];
        b.userInteractionEnabled=YES;
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [self.table reloadData];
    }
    else if([btn.titleLabel.text isEqualToString:@"保存"])
    {
        UIButton *b=(UIButton *)[self.view viewWithTag:800];
        b.userInteractionEnabled=NO;
        isEdit=NO;
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.table reloadData];
        [self modifyUserInfo];

    }
}
#pragma mark-修改数据
-(void)modifyUserInfo
{
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    for(int i=0;i<self.dicArray.count;i++)
    {
        if([self.userDic objectForKey:self.dicArray[i]]==nil)
        {
            [self.userDic setObject:self.uInfo[i] forKey:self.dicArray[i]];
        }
    }
    
       NSString *headimage=[NSString stringWithFormat:@"/newimage/headimage_%@.jpg",self.model.UserId];
      [self.userDic setObject:self.sexString forKey:@"sex"];
       [self.userDic setObject:self.dateString forKey:@"birthday"];
        if(self.headimage)
        {
            [self.userDic setObject:headimage forKey:@"headImage"];
        }
         [self.userDic setObject:self.model.UserId forKey:@"UserId"];
   
      NSLog(@"dic=%@",self.userDic);
    
       [delegate.manager GET:MODIFYUSERURL parameters:self.userDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
           NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
           if([str isEqualToString:@"isSuccess"])
           {
               NSLog(@"我成功了");
               
           }

    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [delegate.manager POST:MODIFUSERHEADIMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //修改图片大小
        UIGraphicsBeginImageContext(CGSizeMake(60, 60));
        [self.headimage drawInRect:CGRectMake(0, 0, 60, 60)];
    
        UIImage *newimage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImageJPEGRepresentation(newimage, 1);
        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
       // NSLog(@"%@",imageData);
        // 上传图片，以文件流的格式
        
        NSString *headimage=[NSString stringWithFormat:@"headimage_%@.jpg",self.model.UserId];
        [formData appendPartWithFileData:imageData name:@"uploadedfile" fileName:headimage    mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *path=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",path);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR=%@",error);
    }];

}
//nihao.jpg

#pragma mark-tableview协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==105)
    return self.nameLabel.count;
    if(tableView.tag==110)
        return 2;
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"cellid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if(tableView.tag==105)
    {
    UILabel *label=[MyKit createLabel:CGRectMake(10, 8, 100, 20) WithFont:[UIFont systemFontOfSize:14]];
    label.textColor=RGBCOLOR(180, 180, 180);
    label.text=self.nameLabel[indexPath.row];
    [cell.contentView addSubview:label];
    if(indexPath.row==5||indexPath.row==6)
    {
        UILabel *text=[MyKit createLabel:CGRectMake(10, 35, 200, 15) WithFont:[UIFont systemFontOfSize:16]];
        //text.text=@"18355512478";
        [cell.contentView addSubview:text];
        if(indexPath.row==5)
        {
            text.text=self.sexString;
        }
        if(indexPath.row==6)
        {
            text.text=self.dateString;
        }
    }
    else
    {
    UITextField *text=[MyKit createTextField:CGRectMake(10, 35, 200, 15) WithFont:[UIFont systemFontOfSize:16]];
    text.borderStyle=UITextBorderStyleNone;
    text.clearButtonMode=  UITextFieldViewModeWhileEditing;
        text.tag=indexPath.row+300;
        text.text=self.uInfo[indexPath.row];
        text.delegate=self;
        [cell.contentView addSubview:text];
    }
    }
    else if(tableView.tag==110)
        cell.textLabel.text=self.sexArray[indexPath.row];
    if(isEdit)
    {
        cell.userInteractionEnabled=YES;
    }
    else
    {
        cell.userInteractionEnabled=NO;
    }
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark-textfiled的协议方法
-(void)textFieldDidEndEditing:(UITextField *)textField
{
  
    [self.userDic setObject:textField.text forKey:self.dicArray[textField.tag-300]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==105)
    return 65;
    else if(tableView.tag==110)
        return 44;
    return 0;
        
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark-上传头像
-(void)headImageClick:(UIButton *)btn
{
    UIImagePickerController *ctrl=[[UIImagePickerController alloc]init];
    ctrl.delegate=self;
    ctrl.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:ctrl animated:YES completion:nil];
}
#pragma mark-UIImagePickerController代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    UIButton *btn=(UIButton *)[self.view viewWithTag:800];
    self.headimage=image;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if(tableView.tag==105)
    {
        if(indexPath.row==5||indexPath.row==6)
        {
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view1.backgroundColor=[UIColor blackColor];
    view1.tag=100;
    view1.alpha=0.7;
    [self.navigationController.view addSubview:view1];
    if(indexPath.row==5)
    {
        [self createSexView];
       
     }
        else if(indexPath.row==6)
        {
            [self createBirthdayPick];
        }
        }
    }
    else if(tableView.tag==110)
    {
        NSLog(@"%ld",tableView.tag);
        //self.sexString=nil;
        self.sexString=self.sexArray[indexPath.row];
        UIView *v=(UIView *)[self.navigationController.view viewWithTag:101];
        [v removeFromSuperview];
        v=nil;
        UIView *v1=(UIView *)[self.navigationController.view viewWithTag:100];
        [v1 removeFromSuperview];
        v1=nil;
        self.table.alpha=1;
        [self.table reloadData];

    }
}
#pragma mark-创建性别选择器
-(void)createSexView
{
    UIView *view=(UIView *)[self.navigationController.view viewWithTag:100];
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(30,200, SCREEN_WIDTH-60,150)];
    v.backgroundColor=[UIColor whiteColor];
    v.layer.cornerRadius=5;
    v.layer.masksToBounds=YES;
    self.table.alpha=0.3;
    v.tag=101;
    [view addSubview:v];

    UILabel *sex=[MyKit createLabel:CGRectMake(15, 15, v.frame.size.width, 30) WithFont:[UIFont systemFontOfSize:20]];
    sex.text=@"性别";
    sex.textColor=RGBCOLOR(44, 154, 238);
    [v addSubview:sex];
    UIView *line=[MyKit createUIView:CGRectMake(0, 60, v.frame.size.width, 2) WithColor:RGBCOLOR(44, 154, 238)];
    [v addSubview:line];
    CGFloat h=v.frame.size.height-line.frame.size.height-line.frame.origin.y;
    UITableView *sexTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 62, v.frame.size.width,h) style:UITableViewStylePlain];
    sexTable.tag=110;
    sexTable.dataSource=self;
    sexTable.delegate=self;
    [v addSubview:sexTable];
    
}
#pragma mark-创建日期选择器
-(void)createBirthdayPick
{
    UIView *view=(UIView *)[self.navigationController.view viewWithTag:100];
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(30,180, SCREEN_WIDTH-60,320)];
    v.backgroundColor=[UIColor whiteColor];
    v.layer.cornerRadius=5;
    v.layer.masksToBounds=YES;
    self.table.alpha=0.3;
    v.tag=102;
    [view addSubview:v];
    
    UILabel *birthday=[MyKit createLabel:CGRectMake(60, 10, v.frame.size.width, 30) WithFont:[UIFont systemFontOfSize:20]];
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy 年 MM 月 dd 日";
    birthday.text=[formatter stringFromDate:date];
    birthday.tag=109;
    birthday.textColor=RGBCOLOR(44, 154, 238);
    [v addSubview:birthday];
    UIView *line=[MyKit createUIView:CGRectMake(0, 50, v.frame.size.width, 2) WithColor:RGBCOLOR(44, 154, 238)];
    [v addSubview:line];
    UIDatePicker *pick=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 70, v.frame.size.width-40, 80)];
    pick.datePickerMode=UIDatePickerModeDate;
    pick.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    pick.timeZone = [NSTimeZone localTimeZone];
    pick.maximumDate = [NSDate date];
    [pick addTarget:self action:@selector(dpValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    [v addSubview:pick];
    UIButton *btn=[MyKit createBtnFrame:CGRectMake(0, pick.frame.size.height+pick.frame.origin.y, v.frame.size.width, 20) title:@"完成" target:self action:@selector(finishClick:)];
    [v addSubview:btn];

}
#pragma mark-当日期选择器的值改变时，发生的事情
-(void)dpValueChanged:(UIDatePicker *)dp
{
    UILabel *l=(UILabel *)[self.navigationController.view viewWithTag:109];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy 年 MM 月 dd 日";
   l.text=[formatter stringFromDate:dp.date];
   

}
-(void)finishClick:(id)sender
{
      UILabel *l=(UILabel *)[self.navigationController.view viewWithTag:109];
    self.dateString=[NSString stringWithString:l.text];
    UIView *v=(UIView *)[self.navigationController.view viewWithTag:10];
    [v removeFromSuperview];
    v=nil;
    UIView *v1=(UIView *)[self.navigationController.view viewWithTag:100];
    [v1 removeFromSuperview];
    v1=nil;
    self.table.alpha=1;
    [self.table reloadData];
    

}
#pragma mark-加载数据
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end