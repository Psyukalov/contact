//
//  UIView+Custom.h
//
//
//  Created by Vladimir Psyukalov on 22.09.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface UIView (Custom)

- (void)addConstraintsWithView:(UIView *)view;
- (void)addConstraintsWithView:(UIView *)view customInsert:(BOOL)customInsert;

- (void)cornerRadius:(CGFloat)cornerRadius;

- (void)borderWithColor:(UIColor *)color;
- (void)borderWithColor:(UIColor *)color width:(CGFloat)width;

- (void)shadowWithOffset:(CGSize)offset;
- (void)shadowWithOffset:(CGSize)offset color:(UIColor *)color;

- (void)gradientLayerWithColors:(NSArray *)colors;
- (void)gradientLayerWithColors:(NSArray *)colors horizontal:(BOOL)horizontal;
- (void)gradientLayerWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
- (void)gradientLayerWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint locations:(NSArray *)locations;

+ (void)animate:(void (^)(void))animate;
+ (void)animate:(void (^)(void))animate completion:(void (^)(void))completion;
+ (void)animate:(void (^)(void))animate completion:(void (^)(void))completion duration:(CGFloat)duration;

+ (UIImage *)imageWithView:(UIView *)view;

@end
