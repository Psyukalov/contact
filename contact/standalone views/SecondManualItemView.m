//
//  SecondManualItemView.m
//  contact
//
//  Created by Vladimir Psyukalov on 21.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SecondManualItemView.h"


#define kLayer_0_Rate (.84f)
#define kLayer_1_Rate (.64f)
#define kLayer_2_Rate (.64f)


@interface SecondManualItemView ()

@property (weak, nonatomic) IBOutlet UIView *layer_0_View;
@property (weak, nonatomic) IBOutlet UIView *layer_1_View;
@property (weak, nonatomic) IBOutlet UIView *layer_2_View;

@property (weak, nonatomic) IBOutlet UIImageView *layer_0_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *layer_1_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *layer_2_ImageView;

@end


@implementation SecondManualItemView

#pragma mark - Class methods

- (void)playAnimation {
    [super playAnimation];
    [self setHidden:NO animated:YES completion:nil];
}

- (void)stopAnimation {
    [super stopAnimation];
    [self setHidden:YES animated:YES completion:nil];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGAffineTransform bottom_0_Transform = hidden ? CGAffineTransformMakeTranslation(0.f, _layer_0_ImageView.frame.size.height) : CGAffineTransformIdentity;
    CGAffineTransform topTransform = hidden ? CGAffineTransformMakeTranslation(0.f, -.5f * _layer_1_ImageView.frame.size.height) : CGAffineTransformIdentity;
    CGAffineTransform bottom_1_Transform = hidden ? CGAffineTransformMakeTranslation(0.f, .5f * _layer_2_ImageView.frame.size.height) : CGAffineTransformIdentity;
    CGFloat alpha = hidden ? 0.f : 1.f;
    if (animated) {
        [UIView animateWithDuration:.64f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _layer_0_View.transform = bottom_0_Transform;
            _layer_0_View.alpha = alpha;
        } completion:nil];
        [UIView animateWithDuration:.64f delay:.64f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _layer_1_View.transform = topTransform;
            _layer_1_View.alpha = alpha;
        } completion:nil];
        [UIView animateWithDuration:.64f delay:.76f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _layer_2_View.transform = bottom_1_Transform;
            _layer_2_View.alpha = alpha;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        _layer_0_View.transform = bottom_0_Transform;
        _layer_1_View.transform = topTransform;
        _layer_2_View.transform = bottom_1_Transform;
        _layer_0_View.alpha = alpha;
        _layer_1_View.alpha = alpha;
        _layer_2_View.alpha = alpha;
        if (completion) {
            completion();
        }
    }
}

#pragma mark - Overriding properties

- (void)setParallaxPoint:(CGPoint)parallaxPoint {
    [super setParallaxPoint:parallaxPoint];
    CGFloat x = self.parallaxPoint.x;
    CGFloat y = self.parallaxPoint.y;
    [UIView animate:^{
        _layer_0_ImageView.transform = CGAffineTransformMakeTranslation(kLayer_0_Rate * x, -kLayer_0_Rate * y);
        _layer_1_ImageView.transform = CGAffineTransformMakeTranslation(kLayer_1_Rate * x, -kLayer_1_Rate * y);
        _layer_2_ImageView.transform = CGAffineTransformMakeTranslation(kLayer_2_Rate * x, -kLayer_2_Rate * y);
    } completion:nil duration:.16f];
}

#pragma mark - Overriding metods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [self setHidden:YES animated:NO completion:nil];
}

@end
