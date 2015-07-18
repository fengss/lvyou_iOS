//
//  peopleView.m
//
//  Created by coderss on 15/5/9.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "peopleView.h"
#import "HeadFile.h"

@implementation NewButton

// 用户点击按钮，按钮会调用这个方法处理高亮状态
// 重写这个方法，取消按钮的高亮状态
- (void)setHighlighted:(BOOL)highlighted
{
    // 在父类的setHighlighted处理了高亮状态(图片变暗)
    // [super setHighlighted:highlighted];
}

@end
@interface peopleView ()<UITextFieldDelegate>

@end

@implementation peopleView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.sure.layer.cornerRadius=8;
    self.sure.layer.masksToBounds=YES;
    
    self.sexMan.layer.cornerRadius=7.5;
    self.sexMan.layer.masksToBounds=YES;
    self.sexMan.layer.borderWidth=1;
    self.sexMan.layer.borderColor=RGBCOLOR(45, 160, 124).CGColor;
    self.sexMan.backgroundColor=[UIColor whiteColor];
    [self.sexMan setImage:[UIImage imageNamed:@"jschedule-route"] forState:UIControlStateSelected];
    self.sexMan.selected=YES;
    
    self.sexWoman.layer.cornerRadius=7.5;
    self.sexWoman.layer.masksToBounds=YES;
    self.sexWoman.layer.borderWidth=1;
    self.sexWoman.layer.borderColor=RGBCOLOR(45, 160, 124).CGColor;
    self.sexWoman.backgroundColor=[UIColor whiteColor];
    [self.sexWoman setImage:[UIImage imageNamed:@"jschedule-route"] forState:UIControlStateSelected];
    self.sexWoman.selected=NO;
    self.sure.titleEdgeInsets=UIEdgeInsetsMake(0, 40, 0, 0);
    self.cardId.userInteractionEnabled=NO;

    //self.cardId.keyboardType=UIKeyboardTypeNumberPad;
    self.cardId.delegate=self;
    self.name.delegate=self;
    self.name.delegate=self;
}
-(IBAction)manClick:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    btn.selected=YES;
    UIButton *b=(UIButton *)[self viewWithTag:101];
    b.selected=NO;
}
- (IBAction)womanClick:(id)sender {
    NSLog(@"woman被点击了");
    UIButton *btn=(UIButton *)sender;
    btn.selected=YES;
    UIButton *b=(UIButton *)[self viewWithTag:100];
    b.selected=NO;
}
- (IBAction)birthdayClick:(id)sender {
     [self createBirthdayPick];
}
- (IBAction)otherClick:(id)sender {
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(self.other.frame.origin.x+10,self.other.frame.origin.y+self.other.frame.size.height+30,self.other.frame.size.width,62)];
    v.tag=78;
      NSArray *arr=@[@"身份证",@"其他"];
        for(int i=0;i<arr.count;i++)
        {
          NewButton *b=[NewButton buttonWithType:UIButtonTypeSystem];
            b.frame=CGRectMake(0, 0+31*i,v.frame.size.width, 30);
            [b setTitle:arr[i] forState:UIControlStateNormal];
            [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            b.titleLabel.font=[UIFont systemFontOfSize:12];
            b.tag=420+i;
            [v addSubview:b];
            [b addTarget:self action:@selector(choseClick:) forControlEvents:UIControlEventTouchUpInside];
            UIView *line=[[UIView alloc]init];
            line.frame=CGRectMake(0, b.frame.origin.y+b.frame.size.height, b.frame.size.width, 1);
            line.backgroundColor=RGBCOLOR(170, 170, 170);
            [v addSubview:line];
        }
    v.backgroundColor=RGBCOLOR(224, 224, 224);;
    [self addSubview:v];

    
}
-(void)choseClick:(UIButton *)btn
{
    [self.other setTitle:btn.titleLabel.text forState:UIControlStateNormal];
    if(btn.tag==421)
    {
        self.cardId.userInteractionEnabled=NO;
    }
    else
    {
        self.cardId.userInteractionEnabled=YES;
    }
    UIView *v=(UIView *)[self viewWithTag:78];
    for(UIView *view in v.subviews)
    {
        [view removeFromSuperview];
    }
    [v removeFromSuperview];
    v=nil;
}
-(void)createBirthdayPick
 {
 UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
 view.backgroundColor=[UIColor blackColor];
 view.alpha=0.9;
 view.tag=50;
 [self addSubview:view];
 UIView *v=[[UIView alloc]initWithFrame:CGRectMake(30,100, SCREEN_WIDTH-60,320)];
 v.backgroundColor=[UIColor whiteColor];
 v.layer.cornerRadius=5;
 v.layer.masksToBounds=YES;
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
-(void)sureClick:(id)sender
{
    NSString *str;
    if(self.sexMan.selected)
        str=@"男";
    else if(self.sexWoman.selected)
        str=@"女";
    NSString *state;
    if([self.other.titleLabel.text isEqualToString:@"身份证"])
    {
       state=@"成人";
    }
    else
    {
        state=@"儿童";
    }
    NSDictionary *dic=@{@"UserId":self.UserId,
                        @"RealName":self.name.text,
                        @"Sex":str,
                        @"Stust":state,
                        @"IDCard":self.cardId.text};
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.manager GET:CONNUSERURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if([str isEqualToString:@"isSuccess"])
        {
            [self.delegate back];
           
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
 #pragma mark-当日期选择器的值改变时，发生的事情
 -(void)dpValueChanged:(UIDatePicker *)dp
 {
 UILabel *l=(UILabel *)[self viewWithTag:109];
 NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
 formatter.dateFormat=@"yyyy 年 MM 月 dd 日";
 l.text=[formatter stringFromDate:dp.date];


     NSTimeInterval time=[[NSDate date] timeIntervalSinceDate:dp.date];
     if(time<=378432000)
     {
         [self.other setTitle:@"其他" forState:UIControlStateNormal];
         self.cardId.userInteractionEnabled=NO;
         self.other.userInteractionEnabled=NO;
     }
     else
     {
         [self.other setTitle:@"身份证" forState:UIControlStateNormal];
         self.other.userInteractionEnabled=NO;
         self.cardId.userInteractionEnabled=YES;
     }
 }

 -(void)finishClick:(UIButton *)btn
{
    UILabel *l=(UILabel *)[self viewWithTag:109];
 
    [self.birthday setTitle:l.text forState:UIControlStateNormal];
    UIView *v=(UIView *)[self viewWithTag:50];
   for(UIView *view in v.subviews)
    {
     [view removeFromSuperview];
 
      }
    [v removeFromSuperview];
     v=nil;
 
 }
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
