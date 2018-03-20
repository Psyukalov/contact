//
//  VPActivityIndicatorImageView.m
//
//
//  Created by Vladimir Psyukalov on 26.06.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "VPActivityIndicatorImageView.h"


#define KAnimationKey (@"activity_indicator_view_rotate_animation")

#define kFadeInOutDuration (.32f)
#define kScaleRate (.64f)


@interface VPActivityIndicatorImageView ()

@property (strong, nonatomic) CABasicAnimation *animation;

@end


@implementation VPActivityIndicatorImageView

#pragma mark - Class methods

- (void)play {
    [self playWithComlpetion:nil];
}

- (void)playWithComlpetion:(void (^)(void))completion {
    if (_isAnimating) {
        if (completion) {
            completion();
        }
        return;
    }
    _isAnimating = YES;
    [self.layer removeAnimationForKey:KAnimationKey];
    [self.layer addAnimation:_animation forKey:KAnimationKey];
    [UIView animateWithDuration:kFadeInOutDuration delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)stop {
    [self stopWithComlpetion:nil];
}

- (void)stopWithComlpetion:(void (^)(void))completion {
    if (!_isAnimating) {
        if (completion) {
            completion();
        }
        return;
    }
    [UIView animateWithDuration:kFadeInOutDuration delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(kScaleRate, kScaleRate);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        _isAnimating = NO;
        [self.layer removeAnimationForKey:KAnimationKey];
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - Overriding methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Other methods

- (void)setup {
    if (!self.image) {
        self.image = [UIImage imageNamed:@"activity_indicator_image.png"];
    }
    [self sizeToFit];
    self.transform = CGAffineTransformMakeScale(kScaleRate, kScaleRate);
    self.alpha = 0.f;
    self.layer.zPosition = 1024.f;
    _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _animation.fromValue = @0.f;
    _animation.toValue = @(2 * M_PI);
    _animation.duration = 1.f;
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    _animation.repeatCount = INFINITY;
}

@end
