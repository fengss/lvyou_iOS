//
//  AdviceTuanView.h
//
//  Created by coderss on 15/5/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"
@class AdviceTuanView;
@protocol AdviceTuanViewDelegate<NSObject>
-(void)back;
-(void)presentPhotoPicker;
@end
@interface AdviceTuanView : UIView
@property (weak, nonatomic) IBOutlet starView *starView1;
@property (weak, nonatomic) IBOutlet starView *starview2;
@property (weak, nonatomic) IBOutlet starView *starView;
@property (weak, nonatomic) IBOutlet UIButton *label1;
@property (weak, nonatomic) IBOutlet UIButton *label2;
@property (weak, nonatomic) IBOutlet UIButton *label3;
@property (weak, nonatomic) IBOutlet UIButton *label4;
@property (weak, nonatomic) IBOutlet UITextView *adview;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property(nonatomic,strong) NSString* UseId;
@property(nonatomic,strong) NSString* WayId;

- (IBAction)chuanPhoto:(id)sender;

- (IBAction)queDing:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *commitClick;
@property(nonatomic,assign) id<AdviceTuanViewDelegate> tuanDelegate;
@property(nonatomic,retain)UIImage *image;

- (IBAction)label1Click:(id)sender;



- (IBAction)label2Click:(id)sender;

- (IBAction)label3Click:(id)sender;
- (IBAction)label4Click:(id)sender;


@end
