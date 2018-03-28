//
//  ConversationView.m
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ConversationView.h"


@interface ConversationView () <ChatViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *infoView;

@property (weak, nonatomic) IBOutlet UIView *closeView;
@property (weak, nonatomic) IBOutlet UILabel *closeLabel;

@end


@implementation ConversationView

#pragma mark - Class properties

#pragma mark - Class methods

#pragma mark - Overriding properties

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _chatView.delegate = self;
    [_closeView cornerRadius:.5f * _closeView.frame.size.height];
    _closeLabel.text = LOCALIZE(@"cv_label_0");
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView_TUI)];
    [_closeView addGestureRecognizer:tapGR];
    [_chatView receiverIsTypingText:YES];
    Message *message_0 = [Message new];
    message_0.message = @"adas dsfdsf fafgdgfag fdgfdg adfg  dfga gdfcvcvbcxvdf v fvcx vfv vfvdfv";
    message_0.date = @"00:28";
    message_0.isDelivered = YES;
    message_0.isOwner = YES;
    Message *message_1 = [Message new];
    message_1.message = @"sdfsdf sfdsdsf dfsfdf  !!!";
    message_1.date = @"00:30";
    message_1.isDelivered = YES;
    message_1.isOwner = YES;
    Message *message_2 = [Message new];
    message_2.message = @"sdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvsdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvsdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvsdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvdfv dfvvxcvd dv vdfz vdfvxcvxcv";
    message_2.date = @"00:42";
    message_2.isDelivered = NO;
    Message *message_3 = [Message new];
    message_3.message = @"sdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvvsdfsf sf sf sdf sdfsdfasf dscv dsv`vdsvf v`dv sd cscv vfdvvdfvdfv dv dfv dfv vx cvv";
    message_3.date = @"01:00";
    message_3.isDelivered = NO;
    _chatView.messages = [NSMutableArray arrayWithArray:@[message_0, message_1, message_2, message_3, message_0, message_1, message_2, message_3, message_0, message_1, message_2, message_3]];
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

#pragma mark - Actions

- (void)closeView_TUI {
    if (self.didCloseViewCompletion) {
        self.didCloseViewCompletion();
    }
}

@end
