//
//  VPTimer.m
//
//
//  Created by Vladimir Psyukalov on 23.06.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "VPTimer.h"


@interface VPTimer ()

@property (strong, nonatomic) NSTimer *timer;

@end


@implementation VPTimer

- (instancetype)init {
    self = [super init];
    if (self) {
        _time = 0.f;
        _rate = 1.f;
    }
    return self;
}

- (instancetype)initTimerWithTime:(NSUInteger)time {
    self = [super init];
    if (self) {
        _time = time;
        _rate = 1.f;
    }
    return self;
}

- (void)start {
    _count = _time;
    UIBackgroundTaskIdentifier backgroundTask = 0;
    UIApplication  *application = [UIApplication sharedApplication];
    backgroundTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:backgroundTask];
    }];
    NSTimer *currentTimer = [NSTimer scheduledTimerWithTimeInterval:_rate target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:currentTimer forMode:NSRunLoopCommonModes];
    _timer = currentTimer;
}

- (void)setTime:(NSUInteger)time {
    _time = time;
    _count = _time;
    [self calculateTime];
}

- (void)pause {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)stop {
    [self pause];
    _count = 0.f;
}

- (void)tick {
    if (_count > 0) {
        _count -= _rate;
        [self calculateTime];
    } else {
        if (_infinite) {
            if ([_delegate respondsToSelector:@selector(timerDidTick:)]) {
                [_delegate timerDidTick:self];
            }
        } else {
            _count = _time;
            if ([_delegate respondsToSelector:@selector(timerDidTimeEnd:)]) {
                [_delegate timerDidTimeEnd:self];
            }
            [self stop];
        }
    }
}

- (void)calculateTime {
    NSUInteger hours = _count / 3600;
    NSUInteger minutes = (_count / 60) % 60;
    NSUInteger seconds = _count % 60;
    if ([_delegate respondsToSelector:@selector(timerDidTick:)]) {
        [_delegate timerDidTick:self];
    }
    if ([_delegate respondsToSelector:@selector(timer:didTickWithHours:withMinutes:andSeconds:)]) {
        [_delegate timer:self didTickWithHours:hours withMinutes:minutes andSeconds:seconds];
    }
}

@end
