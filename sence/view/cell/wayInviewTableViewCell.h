//
//  wayInviewTableViewCell.h
//
//  Created by coderss on 15/5/2.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WayModel.h"
@interface wayInviewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *shortinfo;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)buyClick:(id)sender;
-(void)configUI:(WayModel *)model;
@end
