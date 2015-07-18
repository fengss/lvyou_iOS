//
//  UserInfoController.h
//
//  Created by coderss on 15/4/30.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
@interface UserInfoController : UIViewController
@property(nonatomic,strong) NSString* UserId;
@property(nonatomic,strong) UserInfo* model;
@property(nonatomic,strong) UIImage* headimage;

@end
