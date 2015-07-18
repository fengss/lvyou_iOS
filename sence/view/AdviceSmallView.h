//
//  AdviceSmallView.h
//
//  Created by coderss on 15/5/3.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdviceSmallView;
@protocol AdviceSmallViewDelegate  <NSObject>

-(void)back;

@end

#import "starView.h"
@interface AdviceSmallView : UIView
@property (weak, nonatomic) IBOutlet starView *starFirst;
@property (weak, nonatomic) IBOutlet starView *starSecond;
@property (weak, nonatomic) IBOutlet UIButton *type;
- (IBAction)typeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *word;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wordHight;
@property (weak, nonatomic) IBOutlet UIButton *finishbtn;
@property(nonatomic,assign) id<AdviceSmallViewDelegate> delegate;
@property(nonatomic,strong) NSString* UserId;
@property(nonatomic,strong) NSString* ViewId;

- (IBAction)finish:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancel;

- (IBAction)concelClick:(id)sender;

@property(nonatomic,assign) void(^myBlock)();

@end
