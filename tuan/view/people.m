//
//  people.m
//
//  Created by coderss on 15/5/9.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "people.h"
#import "HeadFile.h"
@implementation people
int childNum;
int adultNum;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    self.selectBtn.layer.borderColor=RGBCOLOR(245, 111, 9).CGColor;
    self.selectBtn.layer.borderWidth=1;
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"hp-downloaddesc-radio"]forState:UIControlStateSelected];
    self.selectBtn.selected=NO;
 NSMutableDictionary *dic= [[NSUserDefaults standardUserDefaults]objectForKey:@"ConnSelect"];
 BOOL selected=[[dic objectForKey:[NSString stringWithFormat:@"%ld",self.tag]] boolValue];
    
    self.selectBtn.selected=selected;
}
- (IBAction)btnSelect:(id)sender {
    self.selectBtn.selected=!self.selectBtn.selected;

    
}
- (IBAction)edit:(id)sender {
}
-(void)configUI:(ConnModel *)model
{
    if(!model.RealName)
    {
        model.RealName=@"";
    }
    CGFloat w= [model.RealName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,20 ) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width ;
    self.width.constant=w+5;
    self.name.text=model.RealName;
    self.type.text=[NSString stringWithFormat:@"( %@ )",model.Stust];
    if([model.Stust isEqualToString:@"成人"])
    {
        self.Pid.text=model.IDCard;
    }
    else
    {
        self.Pid.text=@"我还是个孩子";
    }
}
@end
