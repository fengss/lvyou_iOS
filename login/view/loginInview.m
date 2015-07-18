//
//  loginInview.m
//
//  Created by coderss on 15/4/27.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "loginInview.h"

#import "HeadFile.h"
#import "ResignView.h"
@interface loginInview()<UIAlertViewDelegate>

@end
@implementation loginInview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews
{
        self.nameAndScrete.layer.cornerRadius=6;
        self.nameAndScrete.layer.masksToBounds=YES;
   
    self.nameAndScrete.layer.cornerRadius=6;
    self.nameAndScrete.layer.masksToBounds=YES;
    self.loginbutton.layer.cornerRadius=6;
    self.loginbutton.layer.masksToBounds=YES;
    self.resignbutton.layer.cornerRadius=6;
    self.resignbutton.layer.masksToBounds=YES;
    


}
- (IBAction)loginsuccess:(id)sender {
    
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *dic=@{@"UserName":self.name.text,
                        @"PassWord":self.secret.text
                        };
    [delegate.manager GET:LOGINURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"data=%@",responseObject);
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:jsondata];
        NSString *str=[dic objectForKey:@"islogin"];
    // NSLog(@"%d",  [str isEqualToString:@"53"]);
//        if([num isEqualToNumber:[NSNumber numberWithInt:53]])
//            NSLog(@"YES");
//            else
//                NSLog(@"NO");
        if([str isEqualToString:@"0"])
        {
            UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"登录失败" message:nil delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
            view.backgroundColor=[UIColor whiteColor];
            view.tag=120;
            [view show];

           
        }
        else
        {
           
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"我要消失了");
            if([self.delegate respondsToSelector:@selector(loginclose)])
            {
                [self.delegate performSelector:@selector(loginclose)];
            }

            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error=%@",error);
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.name.text=@"";
    self.secret.text=@"";
}
- (IBAction)closeclick:(id)sender {
    if([self.delegate respondsToSelector:@selector(loginclose)])
    {
        [self.delegate performSelector:@selector(loginclose)];
    }
}

- (IBAction)resignsuccsee:(id)sender {
    if([self.delegate respondsToSelector:@selector(presentResign)])
    {
        [self.delegate performSelector:@selector(presentResign)];
    }

    }

- (IBAction)sinaclick:(id)sender {
}
@end
