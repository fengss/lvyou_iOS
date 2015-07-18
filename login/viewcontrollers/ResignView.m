//
//  ResignViewController.m
//
//  Created by coderss on 15/4/28.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "ResignView.h"
#import "resignview2.h"
#import "HeadFile.h"
@interface ResignView ()<UITextFieldDelegate,resignview2Delegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property(nonatomic,strong) resignview2* v;
@property(nonatomic,strong) NSMutableData* imageData;


@end

@implementation ResignView

- (void)viewDidLoad {
    [super viewDidLoad];
  self.v=[[[NSBundle mainBundle]loadNibNamed:@"resignview2" owner:self options:nil]lastObject];
    [self.view addSubview:self.v];
    self.v.delegate=self;
    self.v.username.delegate=self;
    self.v.scret.delegate=self;
    self.v.scretagin.delegate=self;
    self.v.email.delegate=self;
    self.v.sure.delegate=self;
    self.imageData=[NSMutableData data];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    
    // 监听键盘隐藏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:@"UIKeyboardWillHideNotification" object:nil];
        NSURL *url=[NSURL URLWithString:SUREURL];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
        NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];

}

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
}


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
    [self.v.sureimage  setBackgroundImage:[UIImage imageWithData:self.imageData] forState:UIControlStateNormal];
    
}

#pragma mark-textfiled 点击return软键盘弹回去
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)resignclose
{
    
    
        [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark-解决键盘遮住textfiled的问题
-(void)keybordWillShow:(NSNotification *)not
{
      NSDictionary *userInfo = not.userInfo;
    NSTimeInterval duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    

    [UIView animateWithDuration:duration animations:^{

    self.v.viewx.constant=38;
    }];
}
- (void)keyboardWillHide:(NSNotification *)not
{
 
    NSDictionary *userInfo = not.userInfo;
    
    // 取出键盘弹出的动画时长
    NSTimeInterval duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    // 修改两个按钮的坐标
    [UIView animateWithDuration:duration animations:^{
         self.v.viewx.constant=48;
        
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
