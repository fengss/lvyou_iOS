//  MyControl.h
//  LimitFreeDemo
//
//  Created by LongHuanHuan on 15/4/12.
//  Copyright (c) 2015年 ___LongHuanHuan___. All rights reserved.

#import "MyControl.h"

@implementation MyControl
#pragma mark 创建View
+(UIView*)createViewWithFrame:(CGRect)frame
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    return view;
    
}
#pragma mark 创建label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(float)font Text:(NSString*)text
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //设置字体
    label.font=[UIFont systemFontOfSize:font];
    //设置折行方式 NSLineBreakByWordWrapping是按照单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //折行限制 0时候是不限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    //设置背景颜色
    label.backgroundColor=[UIColor clearColor];
    //设置文字
    label.text=text;
    //自适应
    //label.adjustsFontSizeToFitWidth=YES;
    return label;
}
#pragma mark 创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame target:(id)target SEL:(SEL)method title:(NSString*)title
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.frame=frame;
    
    [button addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    return button;
}
#pragma mark 创建imageView
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    //用户交互
    imageView.userInteractionEnabled=YES;
    return imageView;
}
#pragma mark 创建textField
+(UITextField*)createTextFieldFrame:(CGRect)frame Font:(float)font textColor:(UIColor*)color leftImageName:(NSString*)leftImageName rightImageName:(NSString*)rightImageName bgImageName:(NSString*)bgImageName
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    textField.font=[UIFont systemFontOfSize:font];
    textField.textColor=color;
    //左边的图片
    UIImage*image=[UIImage imageNamed:leftImageName];
    UIImageView*letfImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    textField.leftView=letfImageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右边的图片
    UIImage*rightImage=[UIImage imageNamed:rightImageName];
    UIImageView*rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rightImage.size.width, rightImage.size.height)];
    textField.rightView=rightImageView;
    textField.rightViewMode=UITextFieldViewModeAlways;
    //清除按钮
    textField.clearButtonMode=YES;
    
    //当再次编辑时候清除
    //textField.clearsOnBeginEditing=YES;
    
    
//    //密码遮掩
//    textField.secureTextEntry
//    //提示框
//    textField.placeholder
    return textField;

}
//适配器 为了适配以前的版本，和现有已经开发的所有功能模块，在原有功能模块基础上进行扩展的方式
+(UITextField*)createTextFieldFrame:(CGRect)frame Font:(float)font textColor:(UIColor*)color leftImageName:(NSString*)leftImageName rightImageName:(NSString*)rightImageName bgImageName:(NSString*)bgImageName placeHolder:(NSString*)placeHolder sucureTextEntry:(BOOL)isOpen
{
   UITextField*textField= [MyControl createTextFieldFrame:frame Font:font textColor:color leftImageName:leftImageName rightImageName:rightImageName bgImageName:bgImageName];
    //适配器扩展出来的方法
    textField.placeholder=placeHolder;
    textField.secureTextEntry=isOpen;
    return textField;
}

@end
