//
//  SMImageView.m
//  contact
//
//  Created by Vladimir Psyukalov on 16.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SMImageView.h"


@implementation SMImageView

#pragma mark - Overriding methods

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didScreenModeChanged) name:kScreenModeChangeNotificationName object:nil];
}

#pragma mark - ScreenModeProtocol

- (void)didScreenModeChanged {
    self.image = [ScreenModeManager shared].isScreenModeDay ? _screenModeDayImage : _screenModeNighImage;
}

@end
