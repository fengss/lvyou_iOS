//
//  PGCategoryView.m
//  分级菜单
//
//  Created by chun on 15/2/28.
//  Copyright (c) 2015年 guang. All rights reserved.
//

#import "PGCategoryView.h"

#define kLeftViewWidth 96

@interface PGCategoryView(){

}

@end

@implementation PGCategoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *bImage = [UIImage imageNamed:@"re_product_pan_b"];
        UIImageView *bImageView = [[UIImageView alloc] initWithImage:bImage];
        bImageView.frame = CGRectMake(30 - bImage.size.width, 0, bImage.size.width, self.bounds.size.height);
        bImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview:bImageView];
        
        
        UIImage *image = [UIImage imageNamed:@"re_prduct_pan_toggle"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGFloat y = (self.bounds.size.height - image.size.height)/2.0;
        imageView.frame = CGRectMake(30 - image.size.width, y, image.size.width, image.size.height);
        _toggleView = imageView;
        [self addSubview:imageView];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}


-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    UIImageView *img = _toggleView;
    CGFloat y = (self.bounds.size.height - img.image.size.height)/2.0;
    img.frame = CGRectMake(30 - img.image.size.width, y, img.image.size.width, img.image.size.height);
}

+(PGCategoryView *)categoryRightView:(UIView *)rightView{
    PGCategoryView *categoryView = [[PGCategoryView alloc] init];
    categoryView.rightView = rightView;
    return categoryView;
}

-(void)show{
    [self hideContent:NO];
}

-(void)hide{
    [self hideContent:YES];
}

-(void)pan:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint location = [gestureRecognizer locationInView:self.superview];
    CGFloat x = location.x;
    NSLog(@"x=%f",x);
    UIGestureRecognizerState state = gestureRecognizer.state;
    
    BOOL animated = NO;
    if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat maxX = kLeftViewWidth + (maxWidth - kLeftViewWidth)/2.0;
        
        if (x <= maxX) {
            x = kLeftViewWidth;
        } else {
            x = self.superview.bounds.size.width;
        }
        animated = YES;
        
    } else if (state == UIGestureRecognizerStateChanged) {
        CGFloat offset = x - kLeftViewWidth;;
        if (offset < 0) {
            x = x - offset/2.0;
        } else {
            animated = YES;
        }
    }
    
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.center = CGPointMake(x- self.bounds.size.width/2.0, self.center.y);
            
            CGRect rect =  _rightView.frame;
            rect.origin.x = x;
             _rightView.frame = rect;
        }];
        return;
    }
    self.center = CGPointMake(x, self.center.y);
    
    CGRect rect =  _rightView.frame;
    rect.origin.x = CGRectGetMaxX(self.frame);
     _rightView.frame = rect;
    
}

- (void)hideContent:(BOOL)hidden {
    CGRect frame =  _rightView.frame;
    CGRect hideFrame = frame;
    CGRect showFrame = frame;
    
    hideFrame.origin.x = self.superview.bounds.size.width;
    showFrame.origin.x = kLeftViewWidth;
    
    if (hidden) {
        [UIView animateWithDuration:0.2 animations:^{
            _rightView.frame = hideFrame;
        } completion:^(BOOL finished) {
             _rightView.hidden = hidden;
            self.hidden = hidden;
        }];
    } else {
        BOOL animateRightContentView = !CGRectEqualToRect(showFrame,  _rightView.frame);
        
        CGRect rect =  self.frame;
        rect.origin.x = CGRectGetMinX(showFrame) - rect.size.width;
        BOOL animatePan = !CGRectEqualToRect(rect, self.frame);
        if (!animatePan && !animateRightContentView) {
            return;
        }
         _rightView.frame = hideFrame;
         _rightView.hidden = NO;
        self.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            if (animateRightContentView) {
                 _rightView.frame = showFrame;
            }
            if (animatePan) {
                self.frame = rect;
            }
        } completion:nil];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect frame = _toggleView.frame;
    frame = CGRectInset(frame, - 5, 0);
    return  CGRectContainsPoint(frame, point);
}


@end
