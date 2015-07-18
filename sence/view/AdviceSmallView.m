//
//  AdviceSmallView.m
//
//  Created by coderss on 15/5/3.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "AdviceSmallView.h"
#import "HeadFile.h"
@interface OtherButton : UIButton
@end



@implementation OtherButton

// 用户点击按钮，按钮会调用这个方法处理高亮状态
// 重写这个方法，取消按钮的高亮状态
- (void)setHighlighted:(BOOL)highlighted
{
    // 在父类的setHighlighted处理了高亮状态(图片变暗)
    // [super setHighlighted:highlighted];
}

@end
@interface AdviceSmallView()<UITextViewDelegate,starViewDelegate>
{
    NSInteger starFirstScore;
    NSInteger starScondScore;
}

@end
@implementation AdviceSmallView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
  
    self.finishbtn.layer.cornerRadius=6;
    self.finishbtn.layer.masksToBounds=YES;
    self.cancel.layer.cornerRadius=6;
    self.cancel.layer.masksToBounds=YES;
    self.type.layer.borderWidth=1;
    self.type.layer.borderColor=[UIColor blackColor].CGColor;
    self.type.layer.cornerRadius=2;
    self.type.layer.masksToBounds=YES;
    self.word.layer.cornerRadius=5;
    self.word.layer.masksToBounds=YES;
    self.word.delegate=self;
    self.word.text=@"亲，写点什么吧，您的意见对其他游客很大帮助！";
    self.word.textColor = [UIColor lightGrayColor];
    self.starFirst.delegate=self;
    self.starSecond.delegate=self;
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 14, 8)];
    image.image=[UIImage imageNamed:@"x"];
    image.hidden=NO;
    image.tag=103;
    [self.type addSubview:image];
    [self.starFirst clean];
    [self.starSecond clean];
    starFirstScore=0;
    starScondScore=0;
    
}
-(void)tapStarView:(starView *)view rating:(NSInteger)rating
{
     if(view.tag==960)
     {
         starFirstScore=rating;
     }
    else
    {
        starScondScore=rating;
    }
}
- (IBAction)typeClick:(id)sender {
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(self.type.frame.origin.x, self.type.frame.origin.y+self.type.frame.size.height+1, self.type.frame.size.width, 124)];
    v.tag=260;
    NSArray *arr=@[@"家庭出游",@"情侣出游",@"朋友出游",@"其他"];
    for(int i=0;i<4;i++)
    {
        OtherButton *b=[OtherButton buttonWithType:UIButtonTypeSystem];
        b.frame=CGRectMake(0, 0+31*i,v.frame.size.width, 30);
        [b setTitle:arr[i] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        b.titleLabel.font=[UIFont systemFontOfSize:12];
        b.tag=100+i;
        [v addSubview:b];
        [b addTarget:self action:@selector(choseClick:) forControlEvents:UIControlEventTouchUpInside];
            UIView *line=[[UIView alloc]init];
        line.frame=CGRectMake(0, b.frame.origin.y+b.frame.size.height, b.frame.size.width, 1);
        line.backgroundColor=[UIColor blackColor];
        [v addSubview:line];
        
    }
    [self addSubview:v];
    v.backgroundColor=RGBCOLOR(234, 235, 240);
}
-(void)choseClick:(UIButton *)btn
{
    [self.type setTitle:btn.titleLabel.text forState:UIControlStateNormal];
    UIView *f=(UIView *)[self viewWithTag:260];
    UIImageView *v=(UIImageView *)[self viewWithTag:103];
    v.hidden=YES;
    [f removeFromSuperview];
    
}
//&ViewId=50&UserId=23&type=dddd&advice=dsdad&statRating=5&time=ddd
- (IBAction)finish:(id)sender {
    CGFloat score=(starFirstScore+starScondScore)/2.0;
    NSDateFormatter *fomatter=[[NSDateFormatter alloc]init];
    fomatter.dateFormat=@"yyyy-MM-dd";
    NSString *date=[fomatter stringFromDate:[NSDate date]];
    NSLog(@"viewId=%@,userid=%@",self.ViewId,self.UserId);
    NSDictionary *dic=@{@"ViewId":self.ViewId,
                        @"UserId":self.UserId,
                        @"type":self.type.titleLabel.text,
                        @"advice":self.word.text,
                        @"statRating":[NSString stringWithFormat:@"%.1f",score],
                        @"time":date
                        };
    AppDelegate *de=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [de.manager GET:USERADVICEVIEWURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
          if([str isEqualToString:@"isSuccess"])
          {
              if([self.delegate respondsToSelector:@selector(back)])
              {
                  [self.delegate performSelector:@selector(back)];
              }

          }
        else
        {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"评论失败，请重新提交" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alter show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}

- (IBAction)concelClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(back)])
    {
        [self.delegate performSelector:@selector(back)];
    }
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    textView.tag = 1;
     return YES;
}
- (void)textViewDidChange:(UITextView *)textView

{
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
@end
