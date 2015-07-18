//
//  AdviceTuanView.m
//
//  Created by coderss on 15/5/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "AdviceTuanView.h"
#import "HeadFile.h"


@interface AdviceTuanView()<starViewDelegate,UIAlertViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    CGFloat rating1;
    CGFloat rating2;
    CGFloat rating3;
    AppDelegate *delegate;
    UITextField *photoName;
    UIImageView *photo;
    int imageCount;
}
@end
@implementation AdviceTuanView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [self.starView1 clean];
    [self.starView clean];
    [self.starview2 clean];
//    [self.label1 setBackgroundImage:[UIImage imageNamed:@"gc_sex1"] forState:UIControlStateNormal];
    [self.label1 setBackgroundImage:[UIImage imageNamed:@"gc_sex0"] forState:UIControlStateSelected];
//    [self.label2 setBackgroundImage:[UIImage imageNamed:@"gc_sex1"] forState:UIControlStateNormal];
    [self.label2 setBackgroundImage:[UIImage imageNamed:@"gc_sex0"] forState:UIControlStateSelected];
//    [self.label3 setBackgroundImage:[UIImage imageNamed:@"gc_sex1"] forState:UIControlStateNormal];
    [self.label3 setBackgroundImage:[UIImage imageNamed:@"gc_sex0"] forState:UIControlStateSelected];
//    [self.label4 setBackgroundImage:[UIImage imageNamed:@"gc_sex1"] forState:UIControlStateNormal];
    [self.label4 setBackgroundImage:[UIImage imageNamed:@"gc_sex0"] forState:UIControlStateSelected];
    self.label1.layer.cornerRadius=13;
    self.label1.layer.masksToBounds=YES;
    self.label2.layer.cornerRadius=13;
    self.label2.layer.masksToBounds=YES;
    self.label3.layer.cornerRadius=13;
    self.label3.layer.masksToBounds=YES;
    self.label4.layer.cornerRadius=13;
    self.label4.layer.masksToBounds=YES;
    self.label1.selected=NO;
    self.label2.selected=NO;
    self.label3.selected=NO;
    self.label4.selected=NO;
    self.adview.text=@"亲，写点什么吧，您的意见对其他游客很大帮助！";
    self.adview.textColor = [UIColor lightGrayColor];
    self.starView.delegate=self;
    self.starView1.delegate=self;
    self.starview2.delegate=self;
    self.adview.delegate=self;
    imageCount=0;
    [self createDone];

}
- (IBAction)label1Click:(id)sender {
     if(self.label1.selected)
     {
         self.label1.selected=NO;
     }
    else
    {
        self.label1.selected=YES;
    }
}

- (IBAction)label2Click:(id)sender {
    if(self.label2.selected)
    {
        self.label2.selected=NO;
    }
    else
    {
        self.label2.selected=YES;
    }

}

- (IBAction)label3Click:(id)sender {
    if(self.label3.selected)
    {
        self.label3.selected=NO;
    }
    else
    {
        self.label3.selected=YES;
    }

}

- (IBAction)label4Click:(id)sender {
    if(self.label4.selected)
    {
        self.label4.selected=NO;
    }
    else
    {
        self.label4.selected=YES;
    }

}
- (IBAction)chuanPhoto:(id)sender {
    
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    v.backgroundColor=RGBCOLOR(217, 230, 240);
    [self addSubview:v];
    v.tag=179;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"tab_1"] forState:UIControlStateNormal];
    btn.frame=CGRectMake(20, 20, 25, 25);
    [btn addTarget:self action:@selector(bacKToAdvice:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn]
    ;
    UILabel *l=[MyKit createLabel:CGRectMake(70,60, 50, 20) WithFont:[UIFont systemFontOfSize:15]];
    l.text=@"标题";
    [v addSubview:l];
    UITextField *name=[MyKit createTextField:CGRectMake(110, 60, 150, 20) WithFont:[UIFont systemFontOfSize:15]];
    [v addSubview:name];
    photoName=name;
    name.delegate=self;
    name.borderStyle=UITextBorderStyleRoundedRect;
    btn.tag=178;
    UIButton *image=[UIButton buttonWithType:UIButtonTypeCustom];
    image.frame=CGRectMake(80, 110, 200, 300);
    [image setImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateNormal];
    [image addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    image.tag=900;
    [v addSubview:image];
    
 
    UIButton *commit=[UIButton buttonWithType:UIButtonTypeSystem];
    [commit setTitle:@"提  交" forState:UIControlStateNormal];
    [commit addTarget:self action:@selector(commitclick:) forControlEvents:UIControlEventTouchUpInside];
    commit.backgroundColor=RGBCOLOR(70, 211, 113);
    commit.frame=CGRectMake(40,450, 295, 40);
    commit.layer.cornerRadius=8;
    commit.layer.masksToBounds=YES;

     [v addSubview:commit ];
    
}
-(void)bacKToAdvice:(UIButton *)btn
{
    UIView *v=(UIView *)[self viewWithTag:179];
    for(UIView *sub in v.subviews)
    {
        [sub removeFromSuperview];
        
    }
    [v removeFromSuperview];
    v=nil;
}
-(void)commitclick:(UIButton *)btn
{
    imageCount++;
    if(imageCount>3)
    {
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"照片数量不能超过3张" message:nil delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil];
        [alter show];
        return;
    }
    AppDelegate *deleget1=(AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate=deleget1;
    UIButton *b=(UIButton *)[self viewWithTag:900];
    NSString *url=[NSString stringWithFormat:USERPHOTOURL,self.UseId];
  [delegate.manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(self.image, 1);
     //  NSLog(@"imageData=%@",imageData);
        NSString *new=[NSString stringWithFormat:@"%@_%@.jpg",self.UseId,photoName.text];
      NSLog(@"url%@,new=%@",url,new);
      
        [formData appendPartWithFileData:imageData name:@"uploadedfile" fileName:new  mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *path=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",path);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR=%@",error);
    }];
      photoName.text=@"";
    
}
- (IBAction)queDing:(id)sender {
    
    AppDelegate *ap=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDateFormatter *fomatter=[[NSDateFormatter alloc]init];
    fomatter.dateFormat=@"yyyy-MM-dd hh:mm";
    NSString *date=[fomatter stringFromDate:[NSDate date]];

    CGFloat rat=(rating1+rating2+rating3)/3.0;
    NSMutableString *de=[NSMutableString string];
    int count=0;
    for(int i=105;i<=108;i++)
    {
        UIButton *btn=(UIButton *)[self viewWithTag:i];
        if(btn.selected)
        {
            [ de appendFormat:@"%@ ",btn.titleLabel.text ];
           count++;
        }
    }
    if(count==0)
    {
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"标签不能为空" message:nil delegate:self cancelButtonTitle:@"确 定" otherButtonTitles:nil];
        [alter show];
        return;
    }
    
   /* NSDictionary *dic=@{
                       // @"@":self.adview.text,
                        @"StarRating":[NSString stringWithFormat:@"%.2f",rat],
                        @"time":date,
                        @"UserId":self.UseId,
                        @"WayId":self.WayId,
                        @"Details":de
                        };
    */
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.adview.text forKey:@"Advice"];
    [dic setObject:[NSString stringWithFormat:@"%.2f",rat] forKey:@"StarRating"];
    [dic setObject:date forKey:@"time"];
    [dic setObject:self.UseId forKey:@"UserId"];
    [dic setObject:self.WayId forKey:@"WayId"];
    [dic setObject:de forKey:@"Details"];
    
    [ap.manager POST:USERADVICEWAYURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"str=%@",str);
        if([str isEqualToString:@"isSuccess"])
        {
            NSLog(@"wochengongle");
            [self.tuanDelegate back];
        
        }
        else
        {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"评论失败，请重新提交" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alter show];

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error=%@",error);
    }];
}
-(void)tapStarView:(starView *)view rating:(NSInteger)rating
{
   if(view.tag==15)
   {
       rating1=rating;
       
   }
   else if(view.tag==16)
   {
       rating2=rating;
   }
    else
    {
        rating3=rating;
    }
       
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    textView.tag = 1;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark-解决textview让键盘消失的原因
-(void)createDone
{
UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];    [topView setBarStyle:UIBarStyleBlackTranslucent];

    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
     UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
     NSArray * buttonsArray = @[btnSpace, doneButton];
   [topView setItems:buttonsArray];
     [self.adview setInputAccessoryView:topView];
}
-(void)dismissKeyBoard
{
    [self.adview resignFirstResponder];
}
#pragma mark-点击后出现相册
-(void)btnClick:(UIButton *)btn
{
    [self.tuanDelegate presentPhotoPicker];
}
@end
