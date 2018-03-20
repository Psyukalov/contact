//
//  SMView.m
//  contact
//
//  Created by Vladimir Psyukalov on 16.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SMView.h"


@implementation SMView

#pragma mark - Overriding methods

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didScreenModeChanged) name:kScreenModeChangeNotificationName object:nil];
}

#pragma mark - ScreenModeProtocol

- (void)didScreenModeChanged {
    self.backgroundColor = [ScreenModeManager shared].isScreenModeDay ? _screenModeDayColor : _screenModeNighColor;
}

@end
