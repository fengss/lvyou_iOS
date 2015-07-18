//
//  view_details.h
//
//  Created by coderss on 15/4/24.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewDetailModel.h"
@interface view_details : UIView
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *reason;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resViewHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reFenHight;
@property (weak, nonatomic) IBOutlet UILabel *jieshao;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jieShaoHight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jieShaoHightSum;

-(NSInteger)configUI:(ViewDetailModel *)model;
@end
