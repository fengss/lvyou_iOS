//
//  resignview2.h
//
//  Created by coderss on 15/4/28.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol resignview2Delegate <NSObject>
-(void)resignclose;
@end
@interface resignview2 : UIView
@property(nonatomic,assign) id<resignview2Delegate>delegate;

- (IBAction)closeclick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *scret;
@property (weak, nonatomic) IBOutlet UITextField *scretagin;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *sure;
@property (weak, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet UIButton *resignbtn;
@property (weak, nonatomic) IBOutlet UIButton *sureimage;

- (IBAction)sureclick:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewhight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewx;

- (IBAction)resignclick:(id)sender;

@end
