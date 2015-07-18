//  MyControl.h
//  LimitFreeDemo
//
//  Created by LongHuanHuan on 15/4/12.
//  Copyright (c) 2015年 ___LongHuanHuan___. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyControl : NSObject
//使用+方法进行创建 是工厂模式中的一种
//工厂模式：传入参数，出来控件
#pragma mark 创建View
+(UIView*)createViewWithFrame:(CGRect)frame;
#pragma mark 创建label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(float)font Text:(NSString*)text;
#pragma mark 创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame target:(id)target SEL:(SEL)method title:(NSString*)title;
#pragma mark 创建imageView
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName;
#pragma mark 创建textField
+(UITextField*)createTextFieldFrame:(CGRect)frame Font:(float)font textColor:(UIColor*)color leftImageName:(NSString*)leftImageName rightImageName:(NSString*)rightImageName bgImageName:(NSString*)bgImageName placeHolder:(NSString*)placeHolder sucureTextEntry:(BOOL)isOpen;
@end
