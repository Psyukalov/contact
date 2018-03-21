//
//  SecondManualItemView.m
//  contact
//
//  Created by Vladimir Psyukalov on 21.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SecondManualItemView.h"


#define kLayer_0_Rate (.32f)
#define kLayer_1_Rate (.64f)
#define kLayer_2_Rate (1.28f)


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

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGAffineTransform topTransform = hidden ? CGAffineTransformMakeTranslation(-_layer_0_ImageView.frame.size.height, 0.f) : CGAffineTransformIdentity;
    CGAffineTransform leftTransform = hidden ? CGAffineTransformMakeTranslation(-_layer_1_ImageView.frame.size.width, 0.f) : CGAffineTransformIdentity;
    CGAffineTransform bottomTransform = hidden ? CGAffineTransformMakeTranslation(_layer_2_ImageView.frame.size.height, 0.f) : CGAffineTransformIdentity;
    CGFloat alpha = hidden ? 0.f : 1.f;
    if (animated) {
        [UIView animateWithDuration:.64f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _layer_2_View.transform = bottomTransform;
            _layer_2_View.alpha = alpha;
        } completion:nil];
        [UIView animateWithDuration:.64f delay:.16f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _layer_1_View.transform = leftTransform;
            _layer_1_View.alpha = alpha;
        } completion:nil];
        [UIView animateWithDuration:.64f delay:.32f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _layer_0_View.transform = topTransform;
            _layer_0_View.alpha = alpha;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        _layer_0_View.transform = topTransform;
        _layer_1_View.transform = leftTransform;
        _layer_2_View.transform = bottomTransform;
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
