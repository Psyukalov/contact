//
//  RequestMessageView.m
//  contact
//
//  Created by Vladimir Psyukalov on 03.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "RequestMessageView.h"


#import "VPTimer.h"


@interface RequestMessageView () <VPTimerDelegate> {
    NSString *localizedWaitingString;
    NSString *localizedMetersString;
    NSString *localizedKilometersString;
}

@property (weak, nonatomic) IBOutlet UILabel *requestLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameAndAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitingLabel;

@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@property (strong, nonatomic) VPTimer *timer;

@end


@implementation RequestMessageView

#pragma mark - Class properties

- (void)setName:(NSString *)name {
    _name = name;
    [self fillRequestMesage];
}

- (void)setAge:(NSUInteger)age {
    _age = age;
    [self fillRequestMesage];
}

- (void)setAutoDeclineTime:(NSUInteger)autoDeclineTime {
    _autoDeclineTime = autoDeclineTime > 0 ? autoDeclineTime : kDefaultAutoDiclineTime;
}

- (void)setDistance:(CGFloat)distance {
    _distance = distance;
    BOOL isKilometers = _distance > 1000.f;
    CGFloat resultDistance = isKilometers ? _distance / 1000.f : _distance;
    NSString *resultUnit = isKilometers ? localizedKilometersString : localizedMetersString;
    _distanceLabel.text = [NSString stringWithFormat:@"%1.f %@", resultDistance, resultUnit];
}

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _requestLabel.text = LOCALIZE(@"rmv_label_0");
    localizedMetersString = LOCALIZE(@"rmv_label_1");
    localizedKilometersString = LOCALIZE(@"rmv_label_2");
    _awayLabel.text = LOCALIZE(@"rmv_label_3");
    localizedWaitingString = LOCALIZE(@"rmv_label_4");
    [_connectButton setTitle:LOCALIZE(@"rmv_button_0") forState:UIControlStateNormal];
    [self setAutoDeclineTime:kDefaultAutoDiclineTime];
    [self fillWaitingLabelWithTime:_autoDeclineTime];
    [_connectButton cornerRadius:.5f * _connectButton.frame.size.height];
    _timer = [VPTimer new];
    _timer.delegate = self;
}

- (void)viewAnimation:(ViewAnimation)viewAnimation animated:(BOOL)animated completion:(void (^)(void))completion {
    [super viewAnimation:viewAnimation animated:animated completion:^{
        if (viewAnimation == ViewAnimationZoomIn || viewAnimation == ViewAnimationFadeIn) {
            [self startCounting];
        }
        if (completion) {
            completion();
        }
    }];
}

- (void)close {
    [_timer stop];
    _timer = nil;
    [super close];
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

- (void)fillRequestMesage {
    NSString *age = _age > 0 ? [NSString stringWithFormat:@", %ld", (unsigned long)_age] : [NSString new];
    _nameAndAgeLabel.text = [NSString stringWithFormat:@"%@%@", _name, age];
}

- (void)startCounting {
    _timer.time = _autoDeclineTime;
    [_timer start];
}

- (void)fillWaitingLabelWithTime:(NSUInteger)time {
    _waitingLabel.text = [NSString stringWithFormat:@"%@: %ld", localizedWaitingString, (unsigned long)time];
}

#pragma mark - Actions

- (IBAction)connectButton_TUI:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(messageViewDidSelectConnect:)]) {
        [_delegate messageViewDidSelectConnect:self];
    }
    [self close];
}

@end
