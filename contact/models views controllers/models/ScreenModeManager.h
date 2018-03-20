//
//  ScreenModeManager.h
//  contact
//
//  Created by Vladimir Psyukalov on 16.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CObject.h"


#define kScreenModeChangeNotificationName (@"screen_mode_change_notification_name")


typedef NS_ENUM(NSUInteger, ScreenMode) {
    ScreenModeDay = 0,
    ScreenModeNight
};


@protocol ScreenModeProtocol <NSObject>

@optional

- (void)didScreenModeChanged;

@end


@interface ScreenModeManager : CObject <NSCoding, CObjectProtocol>

@property (assign, nonatomic) ScreenMode screenMode;

@property (assign, nonatomic, readonly) BOOL isScreenModeDay;
@property (assign, nonatomic, readonly) BOOL isScreenModeNight;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary __attribute__((unavailable("This protocol method is not implemented.")));

- (void)applyScreenMode;

- (void)toggleScreenMode;

@end
