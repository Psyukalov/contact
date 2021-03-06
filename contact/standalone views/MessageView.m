//
//  MessageView.m
//  contact
//
//  Created by Vladimir Psyukalov on 26.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MessageView.h"

#import "AppDelegate.h"


@interface MessageView ()

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end


@implementation MessageView

#pragma mark - Class methods

- (void)close {
    [self viewAnimation:ViewAnimationZoomOut animated:YES completion:^{
        [self removeFromSuperview];
        if (self.didCloseViewCompletion) {
            self.didCloseViewCompletion();
        }
    }];
}

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    self.backgroundColor = [UIColor clearColor];
    CGRect frame = _messageView.frame;
    frame.size.width = WIDTH - 64.f;
    _messageView.frame = frame;
    [_messageView shadowWithOffset:CGSizeZero];
    [_messageView gradientLayerWithColors:@[(id)RGB(32.f, 28.f, 100.f).CGColor, (id)RGB(28.f, 132.f, 242.f).CGColor] horizontal:NO];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addConstraintsWithView:self];
    [self viewAnimation:ViewAnimationZoomOut animated:NO];
}

- (void)viewAnimation:(ViewAnimation)viewAnimation animated:(BOOL)animated completion:(void (^)(void))completion {
    BOOL isInAnimation = viewAnimation == ViewAnimationFadeIn || viewAnimation == ViewAnimationZoomIn;
    CGAffineTransform transform = isInAnimation ? CGAffineTransformIdentity : CGAffineTransformMakeScale(.64f, .64f);
    CGFloat alpha = isInAnimation ? 1.f : 0.f;
    if (animated) {
        [UIView animateWithDuration:.32f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (isInAnimation) {
                self.alpha = alpha;
            } else {
                _messageView.alpha = alpha;
                _messageView.transform = transform;
            }
        } completion:nil];
        [UIView animateWithDuration:.32f delay:.32f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (!isInAnimation) {
                self.alpha = alpha;
            } else {
                _messageView.alpha = alpha;
                _messageView.transform = transform;
            }
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        _messageView.alpha = alpha;
        _messageView.transform = transform;
        self.alpha = alpha;
        if (completion) {
            completion();
        }
    }
}

#pragma mark - Actions

- (IBAction)closeButton_TUI:(UIButton *)sender {
    [self close];
}

@end
