//
//  SMTextView.m
//  contact
//
//  Created by Vladimir Psyukalov on 29.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SMTextView.h"


@implementation SMTextView

#pragma mark - Overriding methods

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didScreenModeChanged) name:kScreenModeChangeNotificationName object:nil];
}

#pragma mark - ScreenModeProtocol

- (void)didScreenModeChanged {
    self.textColor = [ScreenModeManager shared].isScreenModeDay ? _screenModeDayTextColor : _screenModeNighTextColor;
}

@end
