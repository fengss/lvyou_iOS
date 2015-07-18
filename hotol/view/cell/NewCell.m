//
//  NewCell.m
//
//  Created by coderss on 15/5/14.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "NewCell.h"
#import "HeadFile.h"
@implementation NewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configUI:(hotolModel *)model
{
    self.name.text=model.name;
    [self.image setImageWithURL:[NSURL URLWithString:model.images]];
    NSString *str=[NSString stringWithFormat:@"￥%@",model.sellPrice];
    self.price.text=str;
    self.addres.text=model.address;
    CGFloat w=[str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width;
    self.width.constant=w+3;
    if([model.freePark isEqualToString:@"1"])
    {
        self.stop.hidden=NO;
        if([model.freeWifi isEqualToString:@"1"])
        {
            self.wifi.hidden=NO;
        }
    }
    else
    {
        if([model.freeWifi isEqualToString:@"1"])
        {
            self.wifiX.constant=-15;
            self.wifi.hidden=NO;
        }

        
    }
    self.type.text=model.placeType;
  //  self.priceX.constant=w-3;

}
@end
