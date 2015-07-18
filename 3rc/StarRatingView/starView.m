//
//  starView.m
//  starRating
//
//  Created by coderss on 15/5/3.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "starView.h"
@interface starView()
@property(nonatomic,assign) NSInteger rating;

@end
@implementation starView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [self.star1 setImage:[UIImage imageNamed:@"starBg"] forState:UIControlStateNormal];
    [self.star1 setImage:[UIImage imageNamed:@"starFg"] forState:UIControlStateSelected];
    [self.star1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside ];
    
    [self.star2 setImage:[UIImage imageNamed:@"starBg"] forState:UIControlStateNormal];
    self.star1.selected=YES;
    [self.star2 setImage:[UIImage imageNamed:@"starFg"] forState:UIControlStateSelected];
    [self.star2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside ];
    
    [self.star3 setImage:[UIImage imageNamed:@"starBg"] forState:UIControlStateNormal];
    [self.star3 setImage:[UIImage imageNamed:@"starFg"] forState:UIControlStateSelected];
    [self.star3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside ];
    
    [self.star4 setImage:[UIImage imageNamed:@"starBg"] forState:UIControlStateNormal];
    [self.star4 setImage:[UIImage imageNamed:@"starFg"] forState:UIControlStateSelected];
    [self.star4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside ];
 
    [self.star5 setImage:[UIImage imageNamed:@"starBg"] forState:UIControlStateNormal];
    [self.star5 setImage:[UIImage imageNamed:@"starFg"] forState:UIControlStateSelected];
    [self.star5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside ];
     [self.star1 sizeToFit];
     [self.star2 sizeToFit];
    [self.star3 sizeToFit];
    [self.star4 sizeToFit];
    [self.star5 sizeToFit];


}
-(void)btnClick:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    self.rating=btn.tag;
    [self.delegate tapStarView:self rating:self.rating];
    
}
-(void)setRating:(NSInteger)rating
{
    self.star1.selected=rating>=self.star1.tag;
    self.star2.selected=rating>=self.star2.tag;
    self.star3.selected=rating>=self.star3.tag;
    self.star4.selected=rating>=self.star4.tag;
    self.star5.selected=rating>=self.star5.tag;
    _rating=rating;
}
-(void)clean
{
    self.star1.selected=YES;
    self.star2.selected=NO;
      self.star3.selected=NO;
     self.star4.selected=NO;
    self.star5.selected=NO;
}
@end
