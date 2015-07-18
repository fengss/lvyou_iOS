//
//  WayTableViewCell.m
//
//  Created by coderss on 15/4/25.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "WayTableViewCell.h"
#import "HeadFile.h"
/*@property (weak, nonatomic) IBOutlet UIImageView *iconimage;
 @property (weak, nonatomic) IBOutlet UILabel *name;
 
 @property (weak, nonatomic) IBOutlet UILabel *info;
 @property (weak, nonatomic) IBOutlet UILabel *price;
 @property (weak, nonatomic) IBOutlet UIImageView *star;
 */
/*@property(nonatomic,strong) NSString* AdultMoney;
 @property(nonatomic,strong) NSString* ChildMoney;
 @property(nonatomic,strong) NSString* Dengji;
 @property(nonatomic,strong) NSString* ImageUrl;
 @property(nonatomic,strong) NSString* ViewId;
 @property(nonatomic,strong) NSString* Viewstatus;
 @property(nonatomic,strong) NSString* Waydate;
 @property(nonatomic,strong) NSString* WayId;
 @property(nonatomic,strong) NSString* WayInfo;
 @property(nonatomic,strong) NSString* WayName;
 @property(nonatomic,strong) NSString* wayshortinfo;
 @property(nonatomic,strong) NSString* WayType;
 */
 
@implementation WayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark-加载数据
-(void)configUI:(WayModel *)model
{
    NSString *url=[NSString stringWithFormat:IMAGEYUMING,model.ImageUrl];
   // NSLog(@"imageurl=%@",url);
    [self.iconimage setImageWithURL:[NSURL URLWithString:url]];
    self.name.text=model.WayName;
   
    self.info.text=model.wayshortinfo;
    self.info.numberOfLines=0;
    NSString *p=[NSString stringWithFormat:@"%@起",model.ChildMoney];
    self.price.text=p;
   
}
@end
