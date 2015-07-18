//
//  TicketCollectionViewCell.h
//
//  Created by coderss on 15/5/7.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"
@interface TicketCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *endTime;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *count;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceWidth;
-(void)configUI:(TicketModel *)model;
@end
