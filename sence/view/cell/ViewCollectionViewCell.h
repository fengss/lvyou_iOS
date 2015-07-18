//
//  ViewCollectionViewCell.h
//
//  Created by coderss on 15/4/22.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewDetailModel.h"
#import "HeadFile.h"
@protocol ViewCollectionViewCellDelegate <NSObject>
-(void)clickToViewDeatil:(ViewDetailModel *)model;
@end
@interface ViewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *sunbtn;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *shortDetail;
@property(nonatomic,assign) id<ViewCollectionViewCellDelegate> delegate;
@property(nonatomic,strong) ViewDetailModel* Model;

-(void)configUI:(ViewDetailModel*)model;
@end
