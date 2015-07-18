//
//  LyTuanTableViewCell.h
//
//  Created by coderss on 15/4/25.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tourTeamModel.h"
@interface LyTuanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *name;


@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIImageView *ratingstar;


-(void)configUI:(tourTeamModel *)model;
@end
