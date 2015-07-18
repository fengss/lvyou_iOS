//
//  view_details.m
//
//  Created by coderss on 15/4/24.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "view_details.h"
#import "HeadFile.h"
@implementation view_details
-(NSInteger)configUI:(ViewDetailModel *)model
{
    self.address.text=model.Address;
    self.time.text=model.Time;
    self.reason.text=model.reason;
    CGSize size=[Tool strSize:model.reason withMaxSize:CGSizeMake(365, 5000) withFont:[UIFont systemFontOfSize:11] withLineBreakMode:NSLineBreakByWordWrapping];
    self.reFenHight.constant =size.height+5;
    self.resViewHight.constant=size.height+5+30;
    CGSize size1=[Tool strSize:model.details withMaxSize:CGSizeMake(355, 10000) withFont:[UIFont systemFontOfSize:11] withLineBreakMode:NSLineBreakByWordWrapping];
   // NSLog(@"size1=%@",NSStringFromCGSize(size1));
    self.jieShaoHight.constant=size1.height+30;
    self.jieshao.text=model.details;
    self.jieShaoHightSum.constant=size1.height+30+30;
    CGRect rect=self.frame;
     // NSLog(@"yuanself.frame=%@",NSStringFromCGSize(self.frame.size));
    rect.size.height=size1.height+30+30+size.height+140+35;
    self.frame=rect;
    //NSLog(@"self.frame=%@",NSStringFromCGSize(self.frame.size));
    [self layoutIfNeeded];

    return rect.size.height;
    
}
@end