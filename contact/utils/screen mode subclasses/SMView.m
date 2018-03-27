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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - ScreenModeProtocol

- (void)didScreenModeChanged {
    self.backgroundColor = [ScreenModeManager shared].isScreenModeDay ? _screenModeDayColor : _screenModeNighColor;
}

#pragma mark - Other methods

- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didScreenModeChanged) name:kScreenModeChangeNotificationName object:nil];
}

@end
