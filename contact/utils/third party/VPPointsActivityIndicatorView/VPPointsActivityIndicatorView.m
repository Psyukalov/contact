//
//  VPPointsActivityIndicatorView.m
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "VPPointsActivityIndicatorView.h"

#import "SMView.h"

#import "ScreenModeManager.h"


@interface VPPointsActivityIndicatorView ()

@property (strong, nonatomic) SMView *view_0;
@property (strong, nonatomic) SMView *view_1;
@property (strong, nonatomic) SMView *view_2;

@property (strong, nonatomic) NSArray<NSString *> *animationKeys;

@property (strong, nonatomic) CAKeyframeAnimation *opacityAnimation;

@end


@implementation VPPointsActivityIndicatorView

#pragma mark - Class methods

- (void)playAnimation {
    [UIView animateWithDuration:.32f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        NSUInteger i = 0;
        for (UIView *view in @[_view_0, _view_1, _view_2]) {
            CAKeyframeAnimation *opacityAnimation = [_opacityAnimation copy];
            [view.layer setValue:opacityAnimation.values.lastObject forKey:opacityAnimation.keyPath];
            opacityAnimation.beginTime = CACurrentMediaTime() + i * .32f;
            [view.layer addAnimation:opacityAnimation forKey:_animationKeys[i]];
            i++;
        }
    }];
}

- (void)stopAnimation {
    [UIView animateWithDuration:.32f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        NSUInteger i = 0;
        for (UIView *view in @[_view_0, _view_1, _view_2]) {
            [view.layer removeAnimationForKey:_animationKeys[i]];
            i++;
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
    self.alpha = 0.f;
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0.f, 0.f, 26.f, 6.f);
    _view_0 = [[SMView alloc] initWithFrame:CGRectMake(0.f, 0.f, 6.f, 6.f)];
    _view_1 = [[SMView alloc] initWithFrame:CGRectMake(10.f, 0.f, 6.f, 6.f)];
    _view_2 = [[SMView alloc] initWithFrame:CGRectMake(20.f, 0.f, 6.f, 6.f)];
    for (SMView *view in @[_view_0, _view_1, _view_2]) {
        view.layer.cornerRadius = 3.f;
        view.layer.masksToBounds = YES;
        view.screenModeDayColor = [UIColor colorWithRed:34.f / 255.f green:34.f / 255.f blue:40.f / 255.f alpha:1.f];
        view.screenModeNighColor = [UIColor whiteColor];
        view.backgroundColor = view.screenModeNighColor;
        [self addSubview:view];
    }
    _animationKeys = @[@"point_animation_0_key", @"point_animation_1_key", @"point_animation_2_key"];
    _opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    _opacityAnimation.keyTimes = @[@(0.f), @(1.f)];
    _opacityAnimation.values = @[@(.32f), @(1.f)];
    _opacityAnimation.duration = .64f;
    _opacityAnimation.repeatCount = INFINITY;
    _opacityAnimation.autoreverses = YES;
    _opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
}

@end
