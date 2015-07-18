//
//  people.h
//
//  Created by coderss on 15/5/9.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnModel.h"
@interface people : UIView

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
- (IBAction)btnSelect:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *Pid;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;


- (IBAction)edit:(id)sender;
-(void)configUI:(ConnModel *)model;
@end
