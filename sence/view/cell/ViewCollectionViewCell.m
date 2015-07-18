//
//  ViewCollectionViewCell.m
//
//  Created by coderss on 15/4/22.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "ViewCollectionViewCell.h"
#import "ViewDeatilController.h"
@implementation ViewCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        self = [[[NSBundle mainBundle]loadNibNamed:@"ViewCollectionViewCell" owner:self options:nil]firstObject];
        

    }
    return self;

}/*@property (weak, nonatomic) IBOutlet UIButton *sunbtn;
  
  @property (weak, nonatomic) IBOutlet UILabel *name;
  @property (weak, nonatomic) IBOutlet UILabel *price;
  @property (weak, nonatomic) IBOutlet UILabel *shortDetail;
  */
/*
 @property(nonatomic,strong) NSString* ViewName;
 @property(nonatomic,strong) NSString* ViewMoney;
 @property(nonatomic,strong) NSString* Viewinfo;
 @property(nonatomic,strong) NSString* ViewImage;
 @property(nonatomic,strong) NSString* Viewid;
 @property(nonatomic,strong) NSString* Traffic;
 @property(nonatomic,strong) NSString* Time;
 @property(nonatomic,strong) NSString* Regin_id;
 @property(nonatomic,strong) NSString* reason;
 @property(nonatomic,strong) NSString* headimage;
 @property(nonatomic,strong) NSString* details;
 @property(nonatomic,strong) NSString* Address;
 */
-(void)configUI:(ViewDetailModel *)model
{
    NSString *str=[NSString stringWithFormat:YUMING,model.ViewImage];
    [self.sunbtn setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
    [self.sunbtn addTarget:self action:@selector(btnclick_to_detail:) forControlEvents:UIControlEventTouchUpInside];
    self.name.text=model.ViewName;
    NSString *price=[NSString stringWithFormat:@"%@起",model.ViewMoney];
    self.sunbtn.tag=[model.Viewid integerValue];
    self.price.text=price;
    self.shortDetail.text=model.Viewinfo;
    self.shortDetail.numberOfLines=0;
    self.Model=model;
}
-(void)btnclick_to_detail:(UIButton *)btn
{
   
     if([self.delegate respondsToSelector:@selector(clickToViewDeatil:)])
     {
         [self.delegate clickToViewDeatil:self.Model];
     }
    
}
@end
