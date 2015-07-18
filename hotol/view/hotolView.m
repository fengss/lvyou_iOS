//
//  hotolView.m
//
//  Created by coderss on 15/5/14.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "hotolView.h"
#import "appearHotol.h"
@interface hotolView()<UITextFieldDelegate>

@end
@implementation hotolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    self.area.layer.cornerRadius=8;
    self.area.layer.masksToBounds=YES;
    self.areaContent.delegate=self;
    
    self.time.layer.cornerRadius=8;
    self.time.layer.masksToBounds=YES;
    self.dateContent.delegate=self;
    
    self.price.layer.cornerRadius=8;
    self.price.layer.masksToBounds=YES;
    self.priceContent.delegate=self;
    
    self.hotolName.layer.cornerRadius=8;
    self.hotolName.layer.masksToBounds=YES;
    self.hotolContent.delegate=self;


}
//如果是入住和离开时间就弹出的不是软键盘而是时间选择器
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==self.dateContent)
    {
        UIDatePicker *date=[[UIDatePicker alloc]init];
        date.frame=CGRectMake(0, 0,40, 90);
        date.locale=[NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
        date.datePickerMode=UIDatePickerModeDate;
        date.minimumDate=[NSDate dateWithTimeIntervalSinceNow:0];
        date.tag=textField.tag;
        [date addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        textField.inputView=date;
    }
}
//选取一个时间就搜索
-(void)valueChanged:(UIDatePicker *)dp
{
    NSLog(@"%@",dp.date);
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    formatter.timeZone=[NSTimeZone localTimeZone];
    NSString *dateString=[formatter stringFromDate:dp.date];
    self.dateContent.text=dateString;
}
//点击return软键盘收回
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // 让文本输入框取消成为第一响应者，就会自动收起软键盘，并且文本输入框退出编辑状态。
    [textField resignFirstResponder];
    return NO;
}



- (IBAction)commitClick:(id)sender {
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
if(![self.areaContent.text isEqualToString:@""])
{
    [dic setObject:self.areaContent.text forKey:@"area"];
}
    if(![self.priceContent.text isEqualToString:@""])
    {
        [dic setObject:self.priceContent.text forKey:@"price"];
    }
    if(![self.hotolContent.text isEqualToString:@""])
    {
        [dic setObject:self.hotolContent.text forKey:@"name"];
    }
    
    if(self.block)
    self.block(dic);
}
@end
