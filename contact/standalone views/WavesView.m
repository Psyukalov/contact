//
//  WavesView.m
//  contact
//
//  Created by Vladimir Psyukalov on 21.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "WavesView.h"


#define kDelayTime (.64f)
#define kDuration (2.5f)


@interface WavesView ()

@property (weak, nonatomic) IBOutlet UIImageView *wave_0_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *wave_1_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *wave_2_ImageView;

@property (strong, nonatomic) NSArray<NSString *> *animationKeys;

@property (strong, nonatomic) CAAnimationGroup *animationGroup;

@end


@implementation WavesView

#pragma mark - Class methods

- (void)playAnimation {
    NSUInteger i = 0;
    for (UIImageView *imageView in @[_wave_0_ImageView, _wave_1_ImageView, _wave_2_ImageView]) {
        CAAnimationGroup *animationGroup = [_animationGroup copy];
        animationGroup.beginTime = CACurrentMediaTime() + i * kDelayTime + _delay;
        [imageView.layer addAnimation:animationGroup forKey:_animationKeys[i]];
        i++;
    }
}

- (void)stopAnimation {
    NSUInteger i = 0;
    for (UIImageView *imageView in @[_wave_0_ImageView, _wave_1_ImageView, _wave_2_ImageView]) {
        [imageView.layer removeAnimationForKey:_animationKeys[i]];
        i++;
    }
}

#pragma mark - Override methods

- (void)awakeFromNib {
    [super awakeFromNib];
    _animationKeys = @[@"wave_animation_0_key", @"wave_animation_1_key", @"wave_animation_2_key"];
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    scaleAnimation.fromValue = @(0.f);
    scaleAnimation.toValue = @(1.f);
    opacityAnimation.keyTimes = @[@(0.f), @(1.f)];
    opacityAnimation.values = @[@(1.f), @(0.f)];
    _animationGroup = [CAAnimationGroup animation];
    _animationGroup.animations = @[scaleAnimation, opacityAnimation];
    _animationGroup.duration = kDuration;
    _animationGroup.repeatCount = INFINITY;
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    for (UIImageView *imageView in @[_wave_0_ImageView, _wave_1_ImageView, _wave_2_ImageView]) {
        [imageView.layer setValue:opacityAnimation.values.lastObject forKey:opacityAnimation.keyPath];
    }
}

@end
