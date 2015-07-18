//
//  peopleView.h
//
//  Created by coderss on 15/5/9.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol peopleViewDelegate <NSObject>
-(void)back;
@end

@interface peopleView : UIView

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UIButton *sexMan;


@property (weak, nonatomic) IBOutlet UIButton *sexWoman;

- (IBAction)manClick:(id)sender;

- (IBAction)womanClick:(id)sender;

- (IBAction)birthdayClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *birthday;

- (IBAction)otherClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *other;

@property (weak, nonatomic) IBOutlet UIButton *sure;
@property(nonatomic,assign) id<peopleViewDelegate>delegate;

- (IBAction)sureClick:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *cardId;
@property(nonatomic,strong) NSString* UserId;
@end
@interface NewButton : UIButton

@end