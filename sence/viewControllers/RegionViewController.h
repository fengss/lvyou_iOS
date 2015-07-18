//
//  RegionViewController.h
//
//  Created by coderss on 15/4/21.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegionViewController : UIViewController
@property(nonatomic,strong) NSMutableArray* parentArray;
@property(nonatomic,copy) void(^block)(NSString *,NSString *);

@end
