//
//  MyLayout.h
//  TestWaterFlow
//
//  Created by coderss on 15/5/5.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyLayoutDelegte <NSObject>

//返回多少列
- (NSInteger)numberOfColumns;
//每个indexPath对应的cell的高度
- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MyLayout : UICollectionViewLayout

//上下左右的间距
@property (nonatomic,assign)UIEdgeInsets sectionInsets;
//横向间距
@property (nonatomic,assign)CGFloat itemSpace;
//纵向间距
@property (nonatomic,assign)CGFloat lineSpace;
//代理属性
@property (nonatomic,weak)id<MyLayoutDelegte> delegate;


@end
