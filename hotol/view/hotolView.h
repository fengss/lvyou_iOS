//
//  hotolView.h
//
//  Created by coderss on 15/5/14.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol hotolViewDelegate<NSObject>
-(void)searchHotol;
@end
@interface hotolView : UIView

@property (weak, nonatomic) IBOutlet UIView *area;
@property (weak, nonatomic) IBOutlet UITextField *areaContent;

@property (weak, nonatomic) IBOutlet UIView *time;

@property (weak, nonatomic) IBOutlet UITextField *dateContent;
@property (weak, nonatomic) IBOutlet UIView *price;

@property (weak, nonatomic) IBOutlet UITextField *priceContent;
@property (weak, nonatomic) IBOutlet UIView *hotolName;

@property (weak, nonatomic) IBOutlet UITextField *hotolContent;

@property (weak, nonatomic) IBOutlet UIButton *commit;

- (IBAction)commitClick:(id)sender;
@property(nonatomic,copy) void(^block)(NSMutableDictionary *);

@end
