//
//  ProgressHUD.m
//
//  Created by coderss on 14-10-22.
//  Copyright (c) 2014年 coderss. All rights reserved.
//

#import "ProgressHUD.h"


#define  kProgressImageName     (@"ProgressHUD_image.png")
#define  kProgressHUDTag        (10000)
#define  kProgressActivityTag   (20000)


@interface ProgressHUD ()

@property (nonatomic,strong)UILabel *textLabel;

@end

@implementation ProgressHUD

- (id)initWithCenter:(CGPoint)center
{
    self = [super init];
    if (self) {
        
        UIImage *bgImage = [UIImage imageNamed:kProgressImageName];
        
        self.bounds = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
        self.center = center;
                
        UIImageView *imageView = [[UIImageView alloc] initWithImage:bgImage];
        imageView.frame = self.bounds;
        
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = 6;

    }
    
    return self;
}

- (void)show
{
    UIActivityIndicatorView *uaiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    uaiView.tag = kProgressActivityTag;
    uaiView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    uaiView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:uaiView];
    
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.text = @"加载中...";
    self.textLabel.font = [UIFont systemFontOfSize:15];
    [self.textLabel sizeToFit];
    
    self.textLabel.center = CGPointMake(uaiView.center.x, uaiView.frame.origin.y+uaiView.frame.size.height+5+self.textLabel.bounds.size.height/2);
    [self addSubview:self.textLabel];
    
    [uaiView startAnimating];
    
}

- (void)hideActivityView
{
    UIActivityIndicatorView *uiaView = (UIActivityIndicatorView *)[self viewWithTag:kProgressActivityTag];
    [uiaView stopAnimating];
    [uiaView removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)hideAfterSuccess
{
    UIImage *successImage = [UIImage imageNamed:@"保存成功.png"];
    UIImageView *successImageView = [[UIImageView alloc] initWithImage:successImage];
    [successImageView sizeToFit];
    successImageView.center = CGPointMake(self.frame.size.width/2,
                                          self.frame.size.height/2);
    [self addSubview:successImageView];
    self.textLabel.text = @"加载成功";
    [self.textLabel sizeToFit];
    
    [self hideActivityView];
}

- (void)hideAfterFail
{
    self.textLabel.text = @"加载失败";
    [self.textLabel sizeToFit];
    
    [self hideActivityView];
}

+ (void)showOnView:(UIView *)view
{
    UIView *oldHud = [view viewWithTag:kProgressHUDTag];
    if (oldHud) {
        [oldHud removeFromSuperview];
    }
    
    ProgressHUD *hud = [[ProgressHUD alloc] initWithCenter:view.center];
    hud.tag = kProgressHUDTag;
    [view addSubview:hud];
    [hud show];
    
    
}

+ (void)hideAfterSuccessOnView:(UIView *)view
{
    ProgressHUD *hud = (ProgressHUD *)[view viewWithTag:kProgressHUDTag];
    [hud hideAfterSuccess];
    
}

+ (void)hideAfterFailOnView:(UIView *)view
{
    ProgressHUD *hud = (ProgressHUD *)[view viewWithTag:kProgressHUDTag];
    [hud hideAfterFail];
}

+ (void)hideOnView:(UIView *)view
{
    ProgressHUD *hud = (ProgressHUD *)[view viewWithTag:kProgressHUDTag];
    [hud hideActivityView];
}

@end
