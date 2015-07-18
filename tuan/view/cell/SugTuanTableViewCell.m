//
//  SugTuanTableViewCell.m
//
//  Created by ShiYecheng on 15-5-5.
//  Copyright (c) 2015年 cwl. All rights reserved.
//

#import "SugTuanTableViewCell.h"
#import "HeadFile.h"
/*
 @property (weak, nonatomic) IBOutlet UILabel *useName;
 @property (weak, nonatomic) IBOutlet UILabel *Time;
 @property (weak, nonatomic) IBOutlet UILabel *Advice;
 
 @property (weak, nonatomic) IBOutlet UILabel *teamName;
 @property (weak, nonatomic) IBOutlet UILabel *label1;
 
 @property (weak, nonatomic) IBOutlet UILabel *label2;
 @property (weak, nonatomic) IBOutlet UILabel *label3;
 
 @property (weak, nonatomic) IBOutlet UILabel *label4;
 @property (weak, nonatomic) IBOutlet UIView *line;
 
 @property (weak, nonatomic) IBOutlet UIImageView *image1;
 
 @property (weak, nonatomic) IBOutlet UIImageView *image2;
 
 @property (weak, nonatomic) IBOutlet UIImageView *image3;
 
 @property (weak, nonatomic) IBOutlet UIImageView *starImage;
*/
@implementation SugTuanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
 @property(nonatomic,strong) NSString* Advice;
 @property(nonatomic,strong) NSString*  AdviceId;
 @property(nonatomic,strong) NSString*  Details;
 @property(nonatomic,strong) NSString* Image;
 @property(nonatomic,strong) NSString*  StarRating;
 @property(nonatomic,strong) NSString*  teamname;
 @property(nonatomic,strong) NSString* time;
 @property(nonatomic,strong) NSString* UserId;
 @property(nonatomic,strong) NSString* username;
 @property(nonatomic,strong) NSString* WayId;
 */
-(void)configUI:(AdviceTuan *)model
{
    self.useName.text=model.username;
    self.Time.text=model.time;
    CGRect starFrame=self.starImage.frame;
    NSLog(@"statrating=%@",model.StarRating);
    starFrame.size.width=65/5.0*([model.StarRating floatValue]);
    self.starImage.frame=starFrame;
    self.Advice.text=model.Advice;
    CGSize size=[Tool strSize:model.Advice withMaxSize:CGSizeMake(275, 10000) withFont:[UIFont systemFontOfSize:14] withLineBreakMode:NSLineBreakByCharWrapping];
    CGRect adviceRect=self.Advice.frame;
    adviceRect.size.height=size.height+10;
    self.Advice.frame=adviceRect;
    
    self.teamName.text=model.teamname;
    CGRect teamRect=self.teamName.frame;
    teamRect.origin.y=adviceRect.size.height+adviceRect.origin.y+5;
    self.teamName.frame=teamRect;
    
    CGRect shopRect=self.shop.frame;
    shopRect.origin.y=adviceRect.size.height+adviceRect.origin.y+5;
    self.shop.frame=shopRect;
    
    NSArray *labelArray=[model.Details componentsSeparatedByString:@" "];
    for(int i=0;i<labelArray.count;i++)
    {
      //   NSLog(@"count=%ld labelArray=%@",labelArray.count,labelArray[i]);
    }
   
    [self configLabel:self.label1 WithString:labelArray[0]];
   
    if(labelArray.count>=2)
    {
        if(![labelArray[1] isEqualToString:@""])
        {
        self.label2.hidden=NO;
        [self configLabel:self.label2 WithString:labelArray[1]];
        }
        if(labelArray.count>=3)
        {
            if(![labelArray[2] isEqualToString:@""])
            {

              self.label3.hidden=NO;
            [self configLabel:self.label3 WithString:labelArray[2]];
            }
            if(labelArray.count>=4)
            {
                if(![labelArray[3] isEqualToString:@""])
                {

                  self.label4.hidden=NO;
                [self configLabel:self.label4 WithString:labelArray[3]];
                }
            }
            
        }
    }
    if(![model.Image isEqualToString:@""])
    {
        CGRect lineFrame=self.line.frame;
        lineFrame.origin.y=self.label1.frame.origin.y+self.label1.frame.size.height+5;
        self.line.hidden=NO;
        self.line.frame=lineFrame;
        NSArray *imageArray=[model.Image componentsSeparatedByString:@"|"];
        for(int i=0;i<imageArray.count;i++)
        {
      //      NSLog(@"count=%ld image=%@",imageArray.count,imageArray[i]);
        }

         if(imageArray.count>=1)
         {
             self.image1.hidden=NO;
             [self configImage:self.image1 WithUrlString:imageArray[0]];
             if(imageArray.count>=2)
             {
                 
                 if(![imageArray[1] isEqualToString:@""])
                 {
                    [self configImage:self.image2
                     
                        WithUrlString:imageArray[1]];
                     self.image2.hidden=NO;
                 }
                 if(imageArray.count>=3)
                 {
                       self.image3.hidden=NO;
                     if(![imageArray[2] isEqualToString:@""])
                        [self configImage:self.image3 WithUrlString:imageArray[2]];
                 }
             }
             
         }
    }
    else
    {
        self.line.hidden=YES;
    }
    
}
-(void)configLabel:(UILabel *)label WithString:(NSString *)str
{
    if([str isEqualToString:@""])
        return;
    CGRect labelFrame=label.frame;
    labelFrame.origin.y=self.teamName.frame.origin.y+self.teamName.frame.size.height+8;
    CGFloat w = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
    labelFrame.size.width=w+5;
    label.frame=labelFrame;
    label.text=str;
    label.layer.borderWidth=1;
    label.layer.cornerRadius=3;
    label.layer.masksToBounds=YES;
    label.layer.borderColor=RGBCOLOR(247, 142, 140).CGColor;
}
-(void)configImage:(UIButton *)image WithUrlString:(NSString *)str
{
    NSString *url=[NSString stringWithFormat:IMAGEYUMING,str];
  //  NSLog(@"url=%@",url);
    CGRect imageFrame=image.frame;
    imageFrame.origin.y=self.line.frame.size.height+self.line.frame.origin.y+5;
    image.frame=imageFrame;
    [image setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal ];
    
}
+(CGFloat)heightForModel:(AdviceTuan *)model
{
    SugTuanTableViewCell *cell=[[[NSBundle mainBundle]loadNibNamed:@"SugTuanTableViewCell" owner:self options:nil]lastObject];
    CGFloat h=cell.Advice.frame.origin.y;
    CGSize size=[Tool strSize:model.Advice withMaxSize:CGSizeMake(275, 10000) withFont:[UIFont systemFontOfSize:14] withLineBreakMode:NSLineBreakByCharWrapping];
      h+=size.height+10;
    h+=cell.teamName.frame.size.height+5;
    h+=cell.label1.frame.size.height+15;
   // NSLog(@",model.Image%@",model.Image);
    if(model.Image!=nil)
      {
        h+=cell.line.frame.size.height+5;
        h+=cell.image1.frame.size.height+20;
   }
    return h;

}
@end
