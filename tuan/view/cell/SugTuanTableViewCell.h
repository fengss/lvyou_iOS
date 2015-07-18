//
//  SugTuanTableViewCell.h
//
//  Created by ShiYecheng on 15-5-5.
//  Copyright (c) 2015年 cwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdviceTuan.h"
@interface SugTuanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *useName;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UILabel *Advice;

@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UIButton *image1;

@property (weak, nonatomic) IBOutlet UIButton *image2;

@property (weak, nonatomic) IBOutlet UIButton *image3;

@property (weak, nonatomic) IBOutlet UIImageView *starImage;

@property (weak, nonatomic) IBOutlet UILabel *shop;


-(void)configUI:(AdviceTuan *)model;
+(CGFloat)heightForModel:(AdviceTuan *)model;
@end
