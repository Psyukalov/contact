//
//  SearchAnimationView.m
//  contact
//
//  Created by Vladimir Psyukalov on 19.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SearchAnimationView.h"


#define kDelayTime (.64f)


@interface SearchAnimationView ()

@property (weak, nonatomic) IBOutlet UIView *wavesView;

@property (weak, nonatomic) IBOutlet UIImageView *logotypeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *wave_0_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *wave_1_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *wave_2_ImageView;

@property (weak, nonatomic) IBOutlet UILabel *searchingLabel;

@property (strong, nonatomic) NSArray<NSString *> *animationKeys;

@property (strong, nonatomic) CAAnimationGroup *animationGroup;

@end


@implementation SearchAnimationView

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _animationKeys = @[@"search_animation_0_key", @"search_animation_1_key", @"search_animation_2_key"];
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    scaleAnimation.fromValue = @(0.f);
    scaleAnimation.toValue = @(2.f);
    opacityAnimation.keyTimes = @[@(0.f), @(.5f), @(1.f)];
    opacityAnimation.values = @[@(0.f), @(1.f), @(0.f)];
    _animationGroup = [CAAnimationGroup animation];
    _animationGroup.animations = @[scaleAnimation, opacityAnimation];
    _animationGroup.duration = 2.56f;
    _animationGroup.repeatCount = INFINITY;
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    for (UIImageView *imageView in @[_wave_0_ImageView, _wave_1_ImageView, _wave_2_ImageView]) {
        [imageView.layer setValue:scaleAnimation.fromValue forKey:scaleAnimation.keyPath];
        [imageView.layer setValue:opacityAnimation.values.firstObject forKey:opacityAnimation.keyPath];
    }
    _searchingLabel.text = LOCALIZE(@"sav_label_0");
    _wavesView.layer.zPosition = -1024.f;
}

- (void)setNeeded3DEffect:(BOOL)needed3DEffect animated:(BOOL)animated {
    [super setNeeded3DEffect:needed3DEffect animated:animated];
    CGAffineTransform logotypeTransform = CGAffineTransformIdentity;
    CATransform3D transform = CATransform3DIdentity;
    if (self.needed3DEffect) {
        CGAffineTransform transformScale = CGAffineTransformMakeScale(.84f, .84f);
        CGAffineTransform transformTranslation = CGAffineTransformMakeTranslation(0.f, -48.f);
        logotypeTransform = CGAffineTransformConcat(transformScale, transformTranslation);
        transform.m34 = 1.f / 1024.f;
        transform = CATransform3DRotate(transform, DEGREES_TO_RADIANS(-45.f), 1.f, 0.f, 0.f);
    }
    if (animated) {
        [UIView animateWithDuration:.64f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _logotypeImageView.transform = logotypeTransform;
            _wavesView.layer.transform = transform;
        } completion:nil];
    } else {
        _logotypeImageView.transform = logotypeTransform;
        _wavesView.layer.transform = transform;
    }
}

#pragma mark - Class methods

- (void)play {
    NSUInteger i = 0;
    for (UIImageView *imageView in @[_wave_0_ImageView, _wave_1_ImageView, _wave_2_ImageView]) {
        CAAnimationGroup *animationGroup = [_animationGroup copy];
        animationGroup.beginTime = CACurrentMediaTime() + i * kDelayTime;
        [imageView.layer addAnimation:animationGroup forKey:_animationKeys[i]];
        i++;
    }
}

- (void)stop {
    NSUInteger i = 0;
    for (UIImageView *imageView in @[_wave_0_ImageView, _wave_1_ImageView, _wave_2_ImageView]) {
        [imageView.layer removeAnimationForKey:_animationKeys[i]];
        i++;
    }
}

@end
