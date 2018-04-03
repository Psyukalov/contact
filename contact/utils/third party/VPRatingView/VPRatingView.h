//
//  VPRatingView.h
//
//
//  Created by Vladimir Psyukalov on 03.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@class VPRatingView;


@protocol VPRatingViewDelegate <NSObject>

@optional

- (void)ratingView:(VPRatingView *)ratingView didChangeRate:(NSUInteger)rate;

@end


@interface VPRatingView : UIView

@property (weak, nonatomic) id<VPRatingViewDelegate> delegate;

@property (strong, nonatomic) UIImage *defaultImage;
@property (strong, nonatomic) UIImage *selectedImage;

@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) CGFloat padding;
@property (assign, nonatomic) CGFloat margin;

@property (assign, nonatomic) NSUInteger rate;

@end
