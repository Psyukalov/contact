//
//  VPTimer.h
//
//
//  Created by Vladimir Psyukalov on 23.06.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@class VPTimer;


@protocol VPTimerDelegate <NSObject>

@optional

- (void)timer:(VPTimer *)timer didTickWithHours:(NSUInteger)hours withMinutes:(NSUInteger)minutes andSeconds:(NSUInteger)seconds;

- (void)timerDidTick:(VPTimer *)timer;

- (void)timerDidTimeEnd:(VPTimer *)timer;

@end


@interface VPTimer : NSObject

@property (weak, nonatomic) id<VPTimerDelegate> delegate;

@property (assign, nonatomic) NSUInteger time;

@property (assign, nonatomic, readonly) NSUInteger count;

@property (assign, nonatomic) CGFloat rate;

@property (assign, nonatomic) BOOL infinite;

- (instancetype)initTimerWithTime:(NSUInteger)time;

- (void)start;
- (void)pause;
- (void)stop;

@end
