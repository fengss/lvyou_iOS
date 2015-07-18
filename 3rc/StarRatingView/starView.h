//
//  starView.h
//  starRating
//
//  Created by coderss on 15/5/3.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
@class starView;
@protocol starViewDelegate <NSObject>

-(void)tapStarView:(starView *)view rating:(NSInteger)rating;
@end
@interface starView : UIView
@property (weak, nonatomic) IBOutlet UIButton *star1;
@property (weak, nonatomic) IBOutlet UIButton *star2;
@property (weak, nonatomic) IBOutlet UIButton *star3;

@property (weak, nonatomic) IBOutlet UIButton *star4;

@property (weak, nonatomic) IBOutlet UIButton *star5;
@property(nonatomic,assign) id<starViewDelegate> delegate;

-(void)clean;
@end
