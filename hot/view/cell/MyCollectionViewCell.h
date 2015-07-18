//
//  MyCollectionViewCell.h
//
//  Created by coderss on 15/5/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTicketModel.h"

@interface MyCollectionViewCell : UICollectionViewCell
-(void)configUI:(HotTicketModel *)model;
@property (weak, nonatomic) IBOutlet UILabel *type;

@property (weak, nonatomic) IBOutlet UIButton *imageBtn;

@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)btnclick:(id)sender;
+(CGFloat)heightForModel:(HotTicketModel *)model;
@property(nonatomic,assign) void(^block)(void);

@end
