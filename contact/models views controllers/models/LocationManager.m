//
//  LocationManager.m
//
//
//  Created by Vladimir Psyukalov on 04.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "LocationManager.h"


#define OPTIONS_HAS_VALUE(OPTIONS, OPTION) (((OPTIONS) & (OPTION)) == (OPTION))


@interface LocationManager () <CLLocationManagerDelegate>

@property (assign, nonatomic) LocationOptions options;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end


@implementation LocationManager

const LocationOptions LocationOptionsLow = { (LocationUpdateTypeLocation | LocationUpdateTypeHeading), 16.f, 100.f, 0.f };
const LocationOptions LocationOptionsMedium = { (LocationUpdateTypeLocation | LocationUpdateTypeHeading | LocationUpdateTypeGyro), 8.f, 10.f, .32f };
const LocationOptions LocationOptionsHigh  = { (LocationUpdateTypeLocation | LocationUpdateTypeHeading | LocationUpdateTypeGyro), -1.f, -1.f, .08f };

#pragma mark - Instancetype methods

+ (instancetype)shared {
    return [self sharedWithOptions:LocationOptionsLow];
}

+ (instancetype)sharedWithOptions:(LocationOptions)options {
    static LocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [LocationManager managerWithOptions:options];
    });
    return manager;
}

+ (instancetype)managerWithOptions:(LocationOptions)options {
    return [[LocationManager alloc] initWithOptions:options];
}

- (instancetype)initWithOptions:(LocationOptions)options {
    self = [super init];
    if (self) {
        _options = options;
        [self setup];
    }
    return self;
}

- (void)setup {
    if (OPTIONS_HAS_VALUE(_options.updateType, LocationUpdateTypeLocation) || OPTIONS_HAS_VALUE(_options.updateType, LocationUpdateTypeHeading)) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = _options.distanceFilter;
        _locationManager.desiredAccuracy = _options.desiredAccuracy;
    }
    if (OPTIONS_HAS_VALUE(_options.updateType, LocationUpdateTypeGyro)) {
        _motionManager = [CMMotionManager new];
        _motionManager.gyroUpdateInterval = _options.gyroUpdateInterval;
    }
}

#pragma mark - Class properties

- (BOOL)granted {
    BOOL result = NO;
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            break;
        case kCLAuthorizationStatusDenied:
            break;
        case kCLAuthorizationStatusRestricted:
            break;
        default:
            result = YES;
            break;
    }
    return result;
}

#pragma mark - Class methods

- (void)requestAuthorization {
    [_locationManager requestAlwaysAuthorization];
}

- (void)startUpdate {
    if ([self granted]) {
        [_locationManager startUpdatingLocation];
        [_locationManager startUpdatingHeading];
    }
    if (_motionManager.gyroAvailable && !_motionManager.gyroActive) {
        [_motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            if (!error && gyroData && [_dataDelegate respondsToSelector:@selector(manager:didUpdateWithRotationRate:)]) {
                [_dataDelegate manager:self didUpdateWithRotationRate:gyroData.rotationRate];
            }
        }];
    }
}

- (void)stopUpdate {
    [_locationManager stopUpdatingLocation];
    [_locationManager stopUpdatingHeading];
    [_motionManager stopGyroUpdates];
}

- (void)openApplicationSettingsInPhone {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:URL]) {
        [application openURL:URL options:[NSDictionary new] completionHandler:nil];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count > 0 && [_dataDelegate respondsToSelector:@selector(manager:didUpdateWithLocationCoordinate:)]) {
        [_dataDelegate manager:self didUpdateWithLocationCoordinate:locations.lastObject.coordinate];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if ([_dataDelegate respondsToSelector:@selector(manager:didUpdateWithMagneticHeading:)]) {
        [_dataDelegate manager:self didUpdateWithMagneticHeading:newHeading.magneticHeading];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            break;
        case kCLAuthorizationStatusDenied:
            [self declineWithAuthorizationStatus:status];
            break;
        case kCLAuthorizationStatusRestricted:
            [self declineWithAuthorizationStatus:status];
            break;
        default:
            [self startUpdate];
            break;
    }
}

#pragma mark - Other methods

- (void)declineWithAuthorizationStatus:(CLAuthorizationStatus)authorizationStatus {
    [self stopUpdate];
    if ([_delegate respondsToSelector:@selector(manager:didDeclineWithAuthorizationStatus:)]) {
        [_delegate manager:self didDeclineWithAuthorizationStatus:authorizationStatus];
    }
}

@end
