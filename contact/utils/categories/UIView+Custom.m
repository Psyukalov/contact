//
//  UIView+Custom.m
//
//
//  Created by Vladimir Psyukalov on 22.09.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "UIView+Custom.h"


@implementation UIView (Custom)

- (void)addConstraintsWithView:(UIView *)view {
    [self addConstraintsWithView:view customInsert:NO];
}

- (void)addConstraintsWithView:(UIView *)view customInsert:(BOOL)customInsert {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    if (!customInsert) {
        [self addSubview:view];
    }
    NSArray *attributes = @[@(NSLayoutAttributeLeft), @(NSLayoutAttributeTop), @(NSLayoutAttributeRight), @(NSLayoutAttributeBottom)];
    for (NSNumber *attribute in attributes) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:[attribute unsignedIntegerValue] relatedBy:NSLayoutRelationEqual toItem:self attribute:[attribute unsignedIntegerValue] multiplier:1.f constant:0.f]];
    }
}

- (void)cornerRadius:(CGFloat)cornerRadius {
    [self.layer setCornerRadius:cornerRadius];
    self.layer.masksToBounds = YES;
}

- (void)borderWithColor:(UIColor *)color {
    [self borderWithColor:color width:1.f];
}

- (void)borderWithColor:(UIColor *)color width:(CGFloat)width {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)shadowWithOffset:(CGSize)offset {
    [self shadowWithOffset:offset color:[UIColor blackColor]];
}

- (void)shadowWithOffset:(CGSize)offset color:(UIColor *)color {
    self.layer.shadowOffset = offset;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = .32f;
    self.layer.shadowRadius = 6.4f;
    self.layer.masksToBounds = NO;
}

- (void)gradientLayerWithColors:(NSArray *)colors {
    [self gradientLayerWithColors:colors horizontal:YES];
}

- (void)gradientLayerWithColors:(NSArray *)colors horizontal:(BOOL)horizontal {
    CGPoint startPoint = horizontal ? CGPointMake(0.f, .5f) : CGPointMake(.5f, 0.f);
    CGPoint endPoint = horizontal ? CGPointMake(1.f, .5f) :  CGPointMake(.5f, 1.f);
    [self gradientLayerWithColors:colors startPoint:startPoint endPoint:endPoint];
}

- (void)gradientLayerWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    [self gradientLayerWithColors:colors startPoint:startPoint endPoint:endPoint locations:@[@(0.f), @(1.f)]];
}

- (void)gradientLayerWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint locations:(NSArray *)locations {
    CAGradientLayer *layer = [CAGradientLayer layer];
    [layer setFrame:self.bounds];
    layer.colors = colors;
    layer.locations = locations;
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer insertSublayer:layer atIndex:0];
}

+ (void)animate:(void (^)(void))animate {
    [self animate:animate completion:nil];
}

+ (void)animate:(void (^)(void))animate completion:(void (^)(void))completion {
    [self animate:animate completion:completion duration:.32f];
}

+ (void)animate:(void (^)(void))animate completion:(void (^)(void))completion duration:(CGFloat)duration {
    [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (animate) {
            animate();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.f);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
