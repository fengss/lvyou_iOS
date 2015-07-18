//
//  LyTuanTableViewCell.m
//
//  Created by coderss on 15/4/25.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "LyTuanTableViewCell.h"
#import "HeadFile.h"
@implementation LyTuanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*@property(nonatomic,strong) NSString* foundtime;
 @property(nonatomic,strong) NSString* ratingstar;
 @property(nonatomic,strong) NSString* teamid;
 @property(nonatomic,strong) NSString* teamlogo;
 @property(nonatomic,strong) NSString* teamname;

 */
-(void)configUI:(tourTeamModel *)model
{
    NSString *str=[NSString stringWithFormat:IMAGEYUMING,model.teamlogo];
    NSLog(@"%@",str);
    [self.headimage setImageWithURL:[NSURL URLWithString:str]];
    self.name.text=model.teamname;
    NSString *s=[NSString stringWithFormat:@"成立时间：%@,旅游路线:",model.foundtime];
    self.detail.text=s;
    CGRect rect= self.ratingstar.frame;
    rect.size.width=65/5.0*[model.ratingstar floatValue];
    self.ratingstar.frame=rect;
}
@end
