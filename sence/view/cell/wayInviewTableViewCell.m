//
//  wayInviewTableViewCell.m
//
//  Created by coderss on 15/5/2.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "wayInviewTableViewCell.h"
#import "HeadFile.h"
@implementation wayInviewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.btn.layer.cornerRadius=5;
    self.btn.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buyClick:(id)sender {
}
-(void)configUI:(WayModel *)model
{
    [self.headimage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMAGEYUMING,model.ImageUrl]]];
    self.name.text=model.WayName;
    self.price.text=[NSString stringWithFormat:@"%@起",model.ChildMoney];
    self.shortinfo.text=model.wayshortinfo;
    self.shortinfo.numberOfLines=0;
}
@end
