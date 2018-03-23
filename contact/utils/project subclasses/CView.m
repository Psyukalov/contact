//
//  CView.m
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CView.h"

#import "ScreenModeManager.h"


@implementation CView

#pragma mark - Class properties

- (void)setParallaxPoint:(CGPoint)parallaxPoint {
    _parallaxPoint = parallaxPoint;
    _parallaxPoint.x *= _parallaxRadius;
    _parallaxPoint.y *= _parallaxRadius;
}

- (void)setNeeded3DEffect:(BOOL)needed3DEffect {
    [self setNeeded3DEffect:needed3DEffect animated:YES];
}

#pragma mark - Class methods

- (void)viewDirection:(ViewDirection)viewDirection animated:(BOOL)animated {
    [self viewDirection:viewDirection animated:animated completion:nil];
}

- (void)viewDirection:(ViewDirection)viewDirection animated:(BOOL)animated completion:(void (^)(void))completion {
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    CGFloat duration = .64f;
    BOOL hidden = YES;
    switch (viewDirection) {
        case ViewDirectionTop:
            y = -HEIGHT;
            break;
        case ViewDirectionRight:
            x = WIDTH;
            break;
        case ViewDirectionBottom:
            y = HEIGHT;
            break;
        case ViewDirectionLeft:
            x = -WIDTH;
            break;
        case ViewDirectionCenter: {
            duration *= 2.f;
            hidden = NO;
        }
            break;
    }
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (x != 0.f || y != 0.f) {
        transform = CGAffineTransformMakeTranslation(x, y);
    }
    if (!hidden) {
        self.hidden = NO;
    }
    if (animated) {
        [UIView animate:^{
            self.transform = transform;
        } completion:^{
            if (hidden) {
                self.hidden = YES;
            }
            if (completion) {
                completion();
            }
        } duration:duration];
    } else {
        self.transform = transform;
        if (completion) {
            completion();
        }
    }
}

- (void)viewAnimation:(ViewAnimation)viewAnimation animated:(BOOL)animated {
    [self viewAnimation:viewAnimation animated:animated completion:nil];
}

- (void)viewAnimation:(ViewAnimation)viewAnimation animated:(BOOL)animated completion:(void (^)(void))completion {
    CGAffineTransform transform;
    CGFloat alpha;
    switch (viewAnimation) {
        case ViewAnimationFadeIn: {
            transform = CGAffineTransformIdentity;
            alpha = 1.f;
        }
            break;
        case ViewAnimationFadeOut: {
            transform = CGAffineTransformIdentity;
            alpha = 0.f;
        }
            break;
        case ViewAnimationZoomIn: {
            transform = CGAffineTransformIdentity;
            alpha = 1.f;
        }
            break;
        case ViewAnimationZoomOut: {
            transform = CGAffineTransformMakeScale(.64f, .64f);
            alpha = 0.f;
        }
            break;
    }
    if (animated) {
        [UIView animate:^{
            self.transform = transform;
            self.alpha = alpha;
        } completion:^{
            if (completion) {
                completion();
            }
        } duration:.32f];
    } else {
        self.transform = transform;
        self.alpha = alpha;
        if (completion) {
            completion();
        }
    }
}

- (void)setNeeded3DEffect:(BOOL)needed3DEffect animated:(BOOL)animated {
    _needed3DEffect = needed3DEffect;
}

#pragma mark - Ovveride methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [[ScreenModeManager shared] applyScreenMode];
}

@end
