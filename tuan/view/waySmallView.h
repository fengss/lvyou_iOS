//
//  waySmallView.h
//
//  Created by coderss on 15/4/26.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface waySmallView : UIView
@property (weak, nonatomic) IBOutlet UILabel *wayinfo;
@property (weak, nonatomic) IBOutlet UILabel *adultprice;
@property (weak, nonatomic) IBOutlet UILabel *childprice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewframe;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timehight;

@end
