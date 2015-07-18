//
//  WayTableViewCell.h
//
//  Created by coderss on 15/4/25.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WayModel.h"
@interface WayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconimage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *price;

-(void)configUI:(WayModel *)model;
@end
