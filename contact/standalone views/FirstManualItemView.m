//
//  FirstManualItemView.m
//  contact
//
//  Created by Vladimir Psyukalov on 21.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "FirstManualItemView.h"

#import "WavesView.h"


#define kLayer_0_Rate (.32f)
#define kLayer_1_Rate (1.28f)
#define kLayer_2_Rate (3.2f)

#define kLayer_0_Delay (.64f)
#define kLayer_1_Delay (1.28f)
#define kLayer_2_Delay (0.f)


@interface FirstManualItemView ()

@property (weak, nonatomic) IBOutlet UIView *layer_0_View;
@property (weak, nonatomic) IBOutlet UIView *layer_1_View;
@property (weak, nonatomic) IBOutlet UIView *layer_2_View;

@property (weak, nonatomic) IBOutlet UIImageView *layer_0_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *layer_1_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *layer_2_ImageView;

@property (weak, nonatomic) IBOutlet WavesView *wawes_0_View;
@property (weak, nonatomic) IBOutlet WavesView *wawes_1_View;
@property (weak, nonatomic) IBOutlet WavesView *wawes_2_View;

@end


@implementation FirstManualItemView

#pragma mark - Class methods

- (void)playAnimation {
    __weak FirstManualItemView *weakSelf = self;
    [self setHidden:NO animated:YES completion:^{
        [weakSelf playAnimationWaves];
    }];
}

- (void)stopAnimation {
    __weak FirstManualItemView *weakSelf = self;
    [self setHidden:YES animated:YES completion:^{
        [weakSelf stopAnimationWaves];
    }];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGAffineTransform centerTransform = hidden ? CGAffineTransformMakeTranslation(_layer_0_ImageView.frame.size.width, 0.f) : CGAffineTransformIdentity;
    CGAffineTransform leftTransform = hidden ? CGAffineTransformMakeTranslation(-_layer_1_ImageView.frame.size.width, 0.f) : CGAffineTransformIdentity;
    CGAffineTransform rightTransform = hidden ? CGAffineTransformMakeTranslation(_layer_2_ImageView.frame.size.width, 0.f) : CGAffineTransformIdentity;
    CGFloat alpha = hidden ? 0.f : 1.f;
    if (animated) {
        [UIView animateWithDuration:.64f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _layer_2_View.transform = rightTransform;
            _layer_2_View.alpha = alpha;
        } completion:nil];
        [UIView animateWithDuration:.64f delay:.16f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _layer_1_View.transform = leftTransform;
            _layer_1_View.alpha = alpha;
        } completion:nil];
        [UIView animateWithDuration:.64f delay:.32f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _layer_0_View.transform = centerTransform;
            _layer_0_View.alpha = alpha;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        _layer_0_View.transform = centerTransform;
        _layer_1_View.transform = leftTransform;
        _layer_2_View.transform = rightTransform;
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
        _wawes_0_View.transform = _layer_0_ImageView.transform;
        _wawes_1_View.transform = _layer_1_ImageView.transform;
        _wawes_2_View.transform = _layer_2_ImageView.transform;
    } completion:nil duration:.16f];
}

#pragma mark - Overriding metods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _wawes_0_View.delay = kLayer_0_Delay;
    _wawes_1_View.delay = kLayer_1_Delay;
    _wawes_2_View.delay = kLayer_2_Delay;
    [self setHidden:YES animated:NO completion:nil];
}

#pragma mark - Other metods

- (void)playAnimationWaves {
    [_wawes_0_View playAnimation];
    [_wawes_1_View playAnimation];
    [_wawes_2_View playAnimation];
}

- (void)stopAnimationWaves {
    [_wawes_0_View stopAnimation];
    [_wawes_1_View stopAnimation];
    [_wawes_2_View stopAnimation];
}

@end
