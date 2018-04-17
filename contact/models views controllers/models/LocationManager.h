//
//  LocationManager.h
//
//
//  Created by Vladimir Psyukalov on 04.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>


typedef NS_OPTIONS(NSUInteger, LocationUpdateType) {
    LocationUpdateTypeLocation,
    LocationUpdateTypeHeading,
    LocationUpdateTypeGyro
};


typedef struct LocationOptions {
    LocationUpdateType updateType;
    CLLocationDistance distanceFilter;
    CLLocationAccuracy desiredAccuracy;
    NSTimeInterval gyroUpdateInterval;
} LocationOptions;

extern const LocationOptions LocationOptionsLow;
extern const LocationOptions LocationOptionsMedium;
extern const LocationOptions LocationOptionsHigh;

CG_INLINE LocationOptions LocationOptionsMake(LocationUpdateType updateType, CLLocationDistance distanceFilter, CLLocationAccuracy desiredAccuracy, NSTimeInterval gyroUpdateInterval) {
    LocationOptions result;
    result.updateType = updateType;
    result.distanceFilter = distanceFilter;
    result.desiredAccuracy = desiredAccuracy;
    result.gyroUpdateInterval = gyroUpdateInterval;
    return result;
}


@class LocationManager;


@protocol LocationManagerDataDelegate <NSObject>

@optional

- (void)manager:(LocationManager *)manager didUpdateWithLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate;
- (void)manager:(LocationManager *)manager didUpdateWithMagneticHeading:(CLLocationDirection)magneticHeading;
- (void)manager:(LocationManager *)manager didUpdateWithRotationRate:(CMRotationRate)rotationRate;

@end


@protocol LocationManagerDelegate <NSObject>

@optional

- (void)manager:(LocationManager *)manager didDeclineWithAuthorizationStatus:(CLAuthorizationStatus)authorizationStatus;

@end


@interface LocationManager : NSObject

@property (weak, nonatomic) id<LocationManagerDataDelegate> dataDelegate;
@property (weak, nonatomic) id<LocationManagerDelegate> delegate;

@property (assign, nonatomic, readonly) BOOL granted;

+ (instancetype)shared;
+ (instancetype)sharedWithOptions:(LocationOptions)options;

+ (instancetype)managerWithOptions:(LocationOptions)options;

- (instancetype)initWithOptions:(LocationOptions)options;

- (void)requestAuthorization;

- (void)startUpdate;
- (void)stopUpdate;

- (void)openApplicationSettingsInPhone;

@end
