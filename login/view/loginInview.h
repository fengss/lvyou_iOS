//
//  loginInview.h
//
//  Created by coderss on 15/4/27.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol loginInviewDelegate <NSObject>
-(void)loginclose;
-(void)presentResign;
@end
@interface loginInview : UIView
@property (assign, nonatomic) id<loginInviewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *secret;



- (IBAction)loginsuccess:(id)sender;


- (IBAction)closeclick:(id)sender;
- (IBAction)resignsuccsee:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *nameAndScrete;


- (IBAction)sinaclick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *qqcilck;

@property (weak, nonatomic) IBOutlet UIButton *winchatcilck;
@property (weak, nonatomic) IBOutlet UIButton *resignbutton;


@property (weak, nonatomic) IBOutlet UIButton *loginbutton;


@end
