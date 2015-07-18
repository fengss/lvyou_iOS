//
//  MyLayout.m
//
//  Created by coderss on 15/5/5.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout
{
    //列数
    NSInteger _column;
    //存储每一列当前的y值
    NSMutableArray *_columnArray;
    //存储包含每个cell的frame的对象的数组
    NSMutableArray *_attrArray;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        //初始化数组
        _column = 2;
        _columnArray = [NSMutableArray array];
        _attrArray = [NSMutableArray array];
    }
    return self;
}

//每次重新布局的时候会调用
-(void)prepareLayout
{
    [super prepareLayout];
    
    
    //清除之前的数据
    [_columnArray removeAllObjects];
    [_attrArray removeAllObjects];
    
    //一共多少列
    if (self.delegate) {
        _column = [self.delegate numberOfColumns];
    }
    
    //初始化数组
    //默认y值都从上边缘开始
    for (int i=0; i<_column; i++) {
        NSNumber *h = [NSNumber numberWithFloat:self.sectionInsets.top];
        [_columnArray addObject:h];
    }
    
    //一共有多少cell
    NSInteger cellNum = [self.collectionView numberOfItemsInSection:0];
    //计算cell的宽度
    CGFloat allW= self.collectionView.bounds.size.width-self.sectionInsets.left-self.sectionInsets.right-self.itemSpace*(_column-1);
    CGFloat width = allW/_column;
    
    for (int i=0; i<cellNum; i++) {
        
        //计算每个cell的frame，
        //放到一个UICollectionViewLayoutAttributes类型的对象中
        //然后把这些对象放到一个数组中
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //height
        CGFloat height = [self.delegate heightForCellAtIndexPath:indexPath];
        
        //放在哪一列
        NSInteger col = [self findLowestColumnIndex];
        
        //x
        CGFloat x = self.sectionInsets.left+(width+self.itemSpace)*col;
        //y
        CGFloat y = [_columnArray[col] floatValue];
        
        //
        CGRect frame = CGRectMake(x, y, width, height);
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame = frame;
        
        //添加到数组中
        [_attrArray addObject:attr];
        
        
        //更新存储y值数组内容
        _columnArray[col] = [NSNumber numberWithFloat:y+height+self.lineSpace];

    }

}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attrArray;
}

- (CGSize)collectionViewContentSize
{
    NSInteger index = [self findHightestColumnIndex];
    CGFloat height = [_columnArray[index] floatValue];
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

//计算当前y值最大的列
- (NSInteger)findHightestColumnIndex
{
    NSInteger highestIndex = -1;
    CGFloat highestValue = CGFLOAT_MIN;
    
    for (int i=0; i<_columnArray.count; i++) {
        NSNumber *n = _columnArray[i];
        
        if (n.floatValue > highestValue) {
            highestValue = n.floatValue;
            highestIndex = i;
        }
    }
    
    return highestIndex;
}

//计算当前y值最小的列
- (NSInteger)findLowestColumnIndex
{
    CGFloat minValue = CGFLOAT_MAX;
    NSInteger lowestIndex = -1;
    
    //40    60    50
    //minValue=40  lowestIndex=0
    //minValue=40  lowestIndex=0
    //minValue=40  lowestIndex=0
    for (int i=0; i<_columnArray.count; i++) {
        
        NSNumber *n = _columnArray[i];
        
        if (n.floatValue < minValue) {
            minValue = n.floatValue;
            lowestIndex = i;
        }
        
    }
    
    return lowestIndex;
    
}


@end
