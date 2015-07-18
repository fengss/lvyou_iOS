//
//  OrderViewController.h
//
//  Created by coderss on 15/5/7.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WayModel.h"
#import "UserInfo.h"
@interface OrderViewController : UIViewController
@property(nonatomic,strong) WayModel* model;
@property(nonatomic,strong) NSString* UserId;

@end
