//
//  SMButton.m
//  contact
//
//  Created by Vladimir Psyukalov on 16.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SMButton.h"


@implementation SMButton

#pragma mark - Overriding methods

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didScreenModeChanged) name:kScreenModeChangeNotificationName object:nil];
    _screenModeDayDefaultImage = _screenModeDayDefaultImage == nil ? [UIImage new] : _screenModeDayDefaultImage;
    _screenModeNighDefaultImage = _screenModeNighDefaultImage == nil ? [UIImage new] : _screenModeNighDefaultImage;
    _screenModeDayHighlightedImage = _screenModeDayHighlightedImage == nil ? [UIImage new] : _screenModeDayHighlightedImage;
    _screenModeNighHighlightedImage = _screenModeNighHighlightedImage == nil ? [UIImage new] : _screenModeNighHighlightedImage;
    _screenModeDayDisabledImage = _screenModeDayDisabledImage == nil ? [UIImage new] : _screenModeDayDisabledImage;
    _screenModeNighDisabledImage = _screenModeNighDisabledImage == nil ? [UIImage new] : _screenModeNighDisabledImage;
    _screenModeDaySelectedImage = _screenModeDaySelectedImage == nil ? [UIImage new] : _screenModeDaySelectedImage;
    _screenModeNighSelectedImage = _screenModeNighSelectedImage == nil ? [UIImage new] : _screenModeNighSelectedImage;
    _screenModeDayDefaultTextColor = _screenModeDayDefaultTextColor == nil ? [UIColor clearColor] : _screenModeDayDefaultTextColor;
    _screenModeNighDefaultTextColor = _screenModeNighDefaultTextColor == nil ? [UIColor clearColor] : _screenModeNighDefaultTextColor;
    _screenModeDayHighlightedTextColor = _screenModeDayHighlightedTextColor == nil ? [UIColor clearColor] : _screenModeDayHighlightedTextColor;
    _screenModeNighHighlightedTextColor = _screenModeNighHighlightedTextColor == nil ? [UIColor clearColor] : _screenModeNighHighlightedTextColor;
    _screenModeDayDisabledTextColor = _screenModeDayDisabledTextColor == nil ? [UIColor clearColor] : _screenModeDayDisabledTextColor;
    _screenModeNighDisabledTextColor = _screenModeNighDisabledTextColor == nil ? [UIColor clearColor] : _screenModeNighDisabledTextColor;
    _screenModeDaySelectedTextColor = _screenModeDaySelectedTextColor == nil ? [UIColor clearColor] : _screenModeDaySelectedTextColor;
    _screenModeNighSelectedTextColor = _screenModeNighSelectedTextColor == nil ? [UIColor clearColor] : _screenModeNighSelectedTextColor;
    _screenModeDayColor = _screenModeDayColor == nil ? [UIColor clearColor] : _screenModeDayColor;
    _screenModeNighColor = _screenModeNighColor == nil ? [UIColor clearColor] : _screenModeNighColor;
}

#pragma mark - ScreenModeProtocol

- (void)didScreenModeChanged {
    BOOL isScreenModeDay = [ScreenModeManager shared].isScreenModeDay;
    NSArray<UIImage *> *screenModeDayImages = @[_screenModeDayDefaultImage, _screenModeDayHighlightedImage, _screenModeDayDisabledImage, _screenModeDaySelectedImage];
    NSArray<UIImage *> *screenModeNightImages = @[_screenModeNighDefaultImage, _screenModeNighHighlightedImage, _screenModeNighDisabledImage, _screenModeNighSelectedImage];
    NSArray<UIColor *> *screenModeDayColors = @[_screenModeDayDefaultTextColor, _screenModeDayHighlightedTextColor, _screenModeDayDisabledTextColor, _screenModeDaySelectedTextColor];
    NSArray<UIColor *> *screenModeNightColors = @[_screenModeNighDefaultTextColor, _screenModeNighHighlightedTextColor, _screenModeNighDisabledTextColor, _screenModeNighSelectedTextColor];
    NSUInteger i = 0;
    for (NSNumber *numberControlState in @[@(UIControlStateNormal), @(UIControlStateHighlighted), @(UIControlStateDisabled), @(UIControlStateSelected)]) {
        UIControlState controlState = (UIControlState)[numberControlState integerValue];
        UIImage *image = isScreenModeDay ? screenModeDayImages[i] : screenModeNightImages[i];
        UIColor *color = isScreenModeDay ? screenModeDayColors[i] : screenModeNightColors[i];
        [self setImage:image forState:controlState];
        [self setTitleColor:color forState:controlState];
        i++;
    }
    self.backgroundColor = isScreenModeDay ? _screenModeDayColor : _screenModeNighColor;
}

@end
