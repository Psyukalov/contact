//
//  ScreenModeManager.m
//  contact
//
//  Created by Vladimir Psyukalov on 16.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ScreenModeManager.h"


#define kScreenModeKey (@"screen_mode_key")
#define kScreenModeManagerKey (@"screen_mode_manager_key")


@implementation ScreenModeManager

#pragma mark - Class properties

- (void)setScreenMode:(ScreenMode)screenMode {
    _screenMode = screenMode;
    [self save];
    [self applyScreenMode];
}

- (BOOL)isScreenModeDay {
    return _screenMode == ScreenModeDay;
}

- (BOOL)isScreenModeNight {
    return _screenMode == ScreenModeNight;
}

#pragma mark - Class methods

- (void)applyScreenMode {
    [[NSNotificationCenter defaultCenter] postNotificationName:kScreenModeChangeNotificationName object:nil];
}

- (void)toggleScreenMode {
    ScreenMode screenMode = _screenMode == ScreenModeDay ? ScreenModeNight : ScreenModeDay;
    [self setScreenMode:screenMode];
}

#pragma mark - Overriding methods

- (instancetype)init {
    self = [super init];
    if (self) {
        [self load];
    }
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _screenMode = [aDecoder decodeIntegerForKey:kScreenModeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_screenMode forKey:kScreenModeKey];
}

#pragma mark - CObjectProtocol

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self class] new];
    });
    return instance;
}

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:kScreenModeManagerKey];
    [userDefaults synchronize];
}

- (void)load {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:kScreenModeManagerKey];
    ScreenModeManager *screenModeManager = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (screenModeManager) {
        _screenMode = screenModeManager.screenMode;
    }
}

@end
