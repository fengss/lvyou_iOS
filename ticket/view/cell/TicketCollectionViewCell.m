//
//  TicketCollectionViewCell.m
//
//  Created by coderss on 15/5/7.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "TicketCollectionViewCell.h"
#import "HeadFile.h"
/*
 @property(nonatomic,strong) NSString* booktype;
 @property(nonatomic,strong) NSString* buy_price;
 @property(nonatomic,strong) NSString* detail;
 @property(nonatomic,strong) NSString* end_date;
 @property(nonatomic,strong) NSString* feature;
 @property(nonatomic,strong) NSString* first_pub;
 @property(nonatomic,strong) NSString* firstpay_end_time;
 //@property(nonatomic,strong) NSString* id;
 @property(nonatomic,strong) NSString* lastminute_des;
 @property(nonatomic,strong) NSString* list_price;
 @property(nonatomic,strong) NSString* pic;
 @property(nonatomic,strong) NSString* title;
 */
@implementation TicketCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius=8;
    self.layer.masksToBounds=YES;
}
-(void)configUI:(TicketModel *)model
{
    [self.image setImageWithURL:[NSURL URLWithString:model.pic]];
    self.name.text=model.title;
    self.price.text=model.list_price;
    self.endTime.text=model.end_date;
    self.count.text=model.lastminute_des;
   CGFloat w=[model.list_price boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,18) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.width;
   
              self.priceWidth.constant=w+5;
              
}
@end
