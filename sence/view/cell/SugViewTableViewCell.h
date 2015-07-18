//
//  SugViewTableViewCell.h
//
//  Created by coderss on 15/5/2.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewAdvice.h"
@interface SugViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *starrating;
@property (weak, nonatomic) IBOutlet UILabel *advice;
@property (weak, nonatomic) IBOutlet UILabel *time;

+(CGFloat)cellHight:(ViewAdvice *)model;
-(void)configUI:(ViewAdvice *)model;
@end
