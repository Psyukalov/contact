//
//  ConversationView.m
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ConversationView.h"


@interface ConversationView () <ChatViewDelegate> {
    BOOL a;
    NSString *localizedMetersString;
    NSString *localizedKilometersString;
}

@property (weak, nonatomic) IBOutlet UIView *infoView;

@property (weak, nonatomic) IBOutlet UIView *closeView;

@property (weak, nonatomic) IBOutlet UILabel *closeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameAndAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;

@property (weak, nonatomic) IBOutlet UIButton *roleActionButton;

@end


@implementation ConversationView

#pragma mark - Class properties

- (void)setName:(NSString *)name {
    _name = name;
    [self fillRequestMesage];
}

- (void)setAge:(NSUInteger)age {
    _age = age;
    [self fillRequestMesage];
}

- (void)setDistance:(CGFloat)distance {
    _distance = distance;
    BOOL isKilometers = _distance > 1000.f;
    CGFloat resultDistance = isKilometers ? _distance / 1000.f : _distance;
    NSString *resultUnit = isKilometers ? localizedKilometersString : localizedMetersString;
    _distanceLabel.text = [NSString stringWithFormat:@"%1.f %@", resultDistance, resultUnit];
}

#pragma mark - Class methods

#pragma mark - Overriding properties

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _chatView.delegate = self;
    [_closeView cornerRadius:.5f * _closeView.frame.size.height];
    _closeLabel.text = LOCALIZE(@"cv_label_0");
    localizedMetersString = LOCALIZE(@"cv_label_1");
    localizedKilometersString = LOCALIZE(@"cv_label_2");
    _awayLabel.text = LOCALIZE(@"cv_label_3");
    _timeLeftLabel.text = LOCALIZE(@"cv_label_4");UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView_TUI)];
    [_closeView addGestureRecognizer:tapGR];
    // TODO:
    [self setDistance:100.f];
    [self setName:@"Lara Croft"];
    [self setAge:20];
    Message *message_0 = [Message new];
    message_0.text = @"adas dsfdsf fafgdgfag fdgfdg adfg  dfga gdfcvcvbcxvdf v fvcx vfv vfvdfv";
    message_0.date = @"00:28";
    message_0.isDelivered = YES;
    message_0.isOwner = YES;
    Message *message_1 = [Message new];
    message_1.text = @"sdfsdf sfdsdsf dfsfdf  !!!";
    message_1.date = @"00:30";
    message_1.isDelivered = YES;
    message_1.isOwner = YES;
    Message *message_2 = [Message new];
    message_2.text = @"sdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvsdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvsdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvsdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvdfv dfvvxcvd dv vdfz vdfvxcvxcv";
    message_2.date = @"00:42";
    message_2.isDelivered = NO;
    Message *message_3 = [Message new];
    message_3.text = @"sdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvsdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvv";
    message_3.date = @"01:00";
    message_3.isDelivered = NO;
    _chatView.messages = [NSMutableArray arrayWithArray:@[message_0, message_1, message_2, message_3, message_0, message_1, message_2, message_3, message_0, message_1, message_2, message_3]];
    [self repeater];
}

- (void)repeater {
    a = !a;
    _chatView.isReceiverTypingText = a;
    [self performSelector:@selector(repeater) withObject:nil afterDelay:2.f];
}

#pragma mark - ChatViewDelegate

- (void)chatView:(ChatView *)chatView didScrollWithPoint:(CGPoint)point {
    CGFloat y = point.y;
    if (y < 0.f) {
        y = 0.f;
    }
    if (y > chatView.headerSize.height) {
        y = chatView.headerSize.height;
    }
    _infoView.transform = CGAffineTransformMakeTranslation(0.f, -y);
}

#pragma mark - Other methods

- (void)fillRequestMesage {
    NSString *age = _age > 0 ? [NSString stringWithFormat:@", %ld", (unsigned long)_age] : [NSString new];
    _nameAndAgeLabel.text = [NSString stringWithFormat:@"%@%@", _name, age];
}

#pragma mark - Actions

- (void)closeView_TUI {
    if (self.didCloseViewCompletion) {
        self.didCloseViewCompletion();
    }
}

@end
