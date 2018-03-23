//
//  SMTextField.m
//  contact
//
//  Created by Vladimir Psyukalov on 23.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SMTextField.h"

#import "UITextField+Custom.h"

#import "ScreenModeManager.h"


@implementation SMTextField

#pragma mark - Overriding methods

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didScreenModeChanged) name:kScreenModeChangeNotificationName object:nil];
}

#pragma mark - ScreenModeProtocol

- (void)didScreenModeChanged {
    ScreenModeManager *screenModeManager = [ScreenModeManager shared];
    self.textColor = screenModeManager.isScreenModeDay ? _screenModeDayTextColor : _screenModeNighTextColor;
    [self placeholderWithColor:screenModeManager.isScreenModeDay ? _screenModeDayPlaceholderColor : _screenModeNighPlaceholderColor];
}

@end
