//
//  SugViewTableViewCell.m
//
//  Created by coderss on 15/5/2.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "SugViewTableViewCell.h"
#import "HeadFile.h"
@interface SugViewTableViewCell()
{
    CGFloat hight;
}
@end
@implementation SugViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.label.layer.cornerRadius=4;
    self.label.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)cellHight:(ViewAdvice *)model
{
    SugViewTableViewCell *cell=[[SugViewTableViewCell alloc]init];
    
     CGFloat h=[model.advice boundingRectWithSize:CGSizeMake(330, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
          h+=70;
    h+=10+cell.time.frame.size.height+30;
    return h;
    

}
-(void)configUI:(ViewAdvice *)model
{
    self.username.text=model.UserName;
    self.label.text=model.type;
    CGFloat labelw=[model.type boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.width;
    CGRect labelFrame=self.label.frame;
    labelFrame.size.width=labelw;
    labelFrame.origin.x=SCREEN_WIDTH-labelw-20;
    self.label.frame=labelFrame;
    CGRect frame=self.starrating.frame;
    frame.size.width=65/5.0*([model.statRating floatValue]);
    self.starrating.frame=frame;
    CGFloat h=[model.advice boundingRectWithSize:CGSizeMake(330, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    CGRect adviceFrame=self.advice.frame;
    adviceFrame.size.height=h;
    self.advice.frame=adviceFrame;
    self.advice.text=model.advice;
    self.advice.numberOfLines=0;
    CGRect timeFrame=self.time.frame;
    timeFrame.origin.y=adviceFrame.size.height+adviceFrame.origin.y+5;
    self.time.frame=timeFrame;
    self.time.text=model.time;
    
}
@end
