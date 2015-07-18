//
//  MyCollectionViewCell.m
//
//  Created by coderss on 15/5/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "HeadFile.h"
@implementation MyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)configUI:(HotTicketModel *)model
{
    self.type.text=model.NewsType;
    self.label.text=model.Newtitle;
    NSString *url=[NSString stringWithFormat:IMAGEYUMING,model.headImage];
    NSLog(@"url=%@",url);
    CGFloat LableH=[model.Newtitle boundingRectWithSize:CGSizeMake(170, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    
  
    CGRect frame=self.label.frame;
    frame.size.height=LableH+30;
    self.label.frame=frame;
    [self.imageBtn  setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
}
- (IBAction)btnclick:(id)sender {
//    if(self.block)
//    {
//     self.block();
//    }
}
+(CGFloat)heightForModel:(HotTicketModel *)model
{
    MyCollectionViewCell *cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCollectionViewCell" owner:self options:nil]lastObject];
    CGFloat h=cell.label.frame.origin.y;
    CGFloat LableH=[model.Newtitle boundingRectWithSize:CGSizeMake(170, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;

    h+=LableH+30;
    return h;
    
}                                                                                                                                        @end
