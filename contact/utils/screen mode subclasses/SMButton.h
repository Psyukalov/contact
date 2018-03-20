//
//  SMButton.h
//  contact
//
//  Created by Vladimir Psyukalov on 16.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "ScreenModeManager.h"


@interface SMButton : UIButton <ScreenModeProtocol>

@property (strong, nonatomic) IBInspectable UIImage *screenModeDayDefaultImage;
@property (strong, nonatomic) IBInspectable UIImage *screenModeNighDefaultImage;
@property (strong, nonatomic) IBInspectable UIImage *screenModeDayHighlightedImage;
@property (strong, nonatomic) IBInspectable UIImage *screenModeNighHighlightedImage;
@property (strong, nonatomic) IBInspectable UIImage *screenModeDayDisabledImage;
@property (strong, nonatomic) IBInspectable UIImage *screenModeNighDisabledImage;
@property (strong, nonatomic) IBInspectable UIImage *screenModeDaySelectedImage;
@property (strong, nonatomic) IBInspectable UIImage *screenModeNighSelectedImage;

@property (strong, nonatomic) IBInspectable UIColor *screenModeDayDefaultTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighDefaultTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeDayHighlightedTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighHighlightedTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeDayDisabledTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighDisabledTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeDaySelectedTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighSelectedTextColor;

@property (strong, nonatomic) IBInspectable UIColor *screenModeDayColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighColor;

@end
