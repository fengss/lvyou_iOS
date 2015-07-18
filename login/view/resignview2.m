//
//  resignview2.m
//
//  Created by coderss on 15/4/28.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "resignview2.h"
#import "AppDelegate.h"
#import "HeadFile.h"
@interface resignview2()<NSURLConnectionDataDelegate,NSURLConnectionDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) NSMutableData* imageData;

@end
@implementation resignview2


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if(self=[super init])
    {
        
    }
    return self;
}
-(void)layoutSubviews
{
    self.imageData=[NSMutableData data];
    self.mainview.layer.cornerRadius=6;
    self.mainview.layer.masksToBounds=YES;
    self.resignbtn.layer.cornerRadius=6;
    self.resignbtn.layer.masksToBounds=YES;
}

- (IBAction)closeclick:(id)sender {
    if([self.delegate respondsToSelector:@selector(resignclose)])
    {
        [self.delegate performSelector:@selector(resignclose)];
    }
    
}



- (IBAction)resignclick:(id)sender {
    
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    if([self.username.text isEqualToString:@""]||[self.scret.text isEqualToString:@""]||[self.scretagin.text isEqualToString:@""]||[self.sure.text isEqualToString:@""]||[self.email.text isEqualToString:@""])
    {
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"不能为空" message:nil delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
        view.backgroundColor=[UIColor whiteColor];
        view.tag=121;
        [view show];

    }
    else
    {
        if([self.scret.text isEqualToString:self.scretagin.text])
        {
            NSDictionary *dic=@{@"UserName":self.username.text,
                                @"PassWord":self.scret.text,
                                @"Email":self.email.text,
                                @"verify":self.sure.text
                                };
            [delegate.manager GET:RESGINEURL  parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:jsondata];
                NSLog(@"%@",dic);
                NSNumber *isSure=[dic objectForKey:@"is_sure"];
                if([isSure isEqualToNumber:@1])
                {
                
                    NSNumber *num=[dic objectForKey:@"hasSameName"];
            
                   if([num isEqualToNumber:@1])
                     {
                      UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提 醒" message:@"已经有该用户,请重新输入" delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
                    
                      alter.tag=122;
                       [alter show];
                      }
                     else
                     {
                       NSNumber *userid= [dic objectForKey:@"isSuccess"];
                      if(userid)
                      {
                         // [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"isLogin"];
                      
                          [[NSUserDefaults standardUserDefaults]setObject:userid forKey:@"isLogin"];
                          [[NSUserDefaults standardUserDefaults] synchronize];

                        NSLog(@"userid=%@",userid);
                          [self.delegate performSelector:@selector(resignclose)];
                      }
                      else
                        {
                        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提 醒" message:@"注册失败" delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
                        
                        alter.tag=123;
                        [alter show];
                        
                       }
                    }
                }
                else
                {
                    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"验证码错误" message:nil delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
                    
                    alter.tag=124;
                    [alter show];

                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];

        }
        else
        {
            UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"两次密码不匹配" message:nil delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
            view.backgroundColor=[UIColor whiteColor];
            view.tag=120;
            [view show];

        }
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==122)
    {
        self.username.text=@"";
        self.scret.text=@"";
        self.scretagin.text=@"";
        self.email.text=@"";
        self.sure.text=@"";
        
    }
    else if(alertView.tag==124)
    {
        self.sure.text=@"";
    }
    else if(alertView.tag==120)
    {
        self.scret.text=@"";
        self.scretagin.text=@"";
        self.sure.text=@"";

    }
    [self.sureimage setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:SUREURL]]] forState:UIControlStateNormal];

}
- (IBAction)sureclick:(id)sender {
    [self.sureimage setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:SUREURL]]] forState:UIControlStateNormal];
}
@end
