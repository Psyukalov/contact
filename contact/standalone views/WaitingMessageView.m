//
//  WaitingMessageView.m
//  contact
//
//  Created by Vladimir Psyukalov on 03.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "WaitingMessageView.h"

#import "VPActivityIndicatorImageView.h"

#import "VPTimer.h"


@interface WaitingMessageView () <VPTimerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitingLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet VPActivityIndicatorImageView *activityIndicatorImageView;

@property (strong, nonatomic) VPTimer *timer;

@end


@implementation WaitingMessageView

#pragma mark - Class properties

- (void)setAutoDeclineTime:(NSUInteger)autoDeclineTime {
    _autoDeclineTime = autoDeclineTime > 0 ? autoDeclineTime : kDefaultAutoDiclineTime;
}

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _contactLabel.text = LOCALIZE(@"wmv_label_0");
    _waitingLabel.text = LOCALIZE(@"wmv_label_1");
    [self setAutoDeclineTime:kDefaultAutoDiclineTime];
    [self fillWaitingLabelWithTime:_autoDeclineTime];
    _timer = [VPTimer new];
    _timer.delegate = self;
    [self timeLabelhidden:YES animated:NO];
}

- (void)viewAnimation:(ViewAnimation)viewAnimation animated:(BOOL)animated completion:(void (^)(void))completion {
    [super viewAnimation:viewAnimation animated:animated completion:^{
        if (viewAnimation == ViewAnimationZoomIn || viewAnimation == ViewAnimationFadeIn) {
            [self startCounting];
            [_activityIndicatorImageView play];
            [self timeLabelhidden:NO animated:YES];
        }
        if (completion) {
            completion();
        }
    }];
}

- (void)close {
    [_timer stop];
    _timer = nil;
    [self timeLabelhidden:YES animated:YES];
    [_activityIndicatorImageView stopWithComlpetion:^{
        [super close];
    }];
}

#pragma mark - VPTimerDelegate

- (void)timer:(VPTimer *)timer didTickWithHours:(NSUInteger)hours withMinutes:(NSUInteger)minutes andSeconds:(NSUInteger)seconds {
    NSUInteger time = 3600 * hours + 60 * minutes + seconds;
    [self fillWaitingLabelWithTime:time];
}

- (void)timerDidTimeEnd:(VPTimer *)timer {
    [self close];
}

#pragma mark - Other methods

- (void)startCounting {
    _timer.time = _autoDeclineTime;
    [_timer start];
}

- (void)fillWaitingLabelWithTime:(NSUInteger)time {
    _timeLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)time];
}

- (void)timeLabelhidden:(BOOL)hidden animated:(BOOL)animated {
    CGFloat alpha = hidden ? 0.f : 1.f;
    CGAffineTransform transform = hidden ? CGAffineTransformMakeScale(.64f, .64f) : CGAffineTransformIdentity;
    if (animated) {
        [UIView animate:^{
            _timeLabel.transform = transform;
            _timeLabel.alpha = alpha;
        } completion:nil duration:.32f];
    } else {
        _timeLabel.transform = transform;
        _timeLabel.alpha = alpha;
    }
}

@end
