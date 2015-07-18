//
//  UserAdviceViewController.h
//
//  Created by coderss on 15/5/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserAdviceViewController : UIViewController
@property(nonatomic,strong) NSString* UserId;
@property(nonatomic,strong) NSString* WayId;
@property(nonatomic,assign)void(^block)();
@end
