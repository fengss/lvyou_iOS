//
//  NewCell.h
//
//  Created by coderss on 15/5/14.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotolModel.h"
@interface NewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *name;


@property (weak, nonatomic) IBOutlet UILabel *type;

@property (weak, nonatomic) IBOutlet UIImageView *stop;

@property (weak, nonatomic) IBOutlet UIImageView *wifi;

@property (weak, nonatomic) IBOutlet UILabel *addres;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceX;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wifiX;
-(void)configUI:(hotolModel *)model;
@end
