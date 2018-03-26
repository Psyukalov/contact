//
//  MessageView.m
//  contact
//
//  Created by Vladimir Psyukalov on 26.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MessageView.h"


@interface MessageView ()

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end


@implementation MessageView

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    self.backgroundColor = [UIColor clearColor];
    [_messageView shadowWithOffset:CGSizeZero ];
    [_messageView gradientLayerWithColors:@[(id)RGB(32.f, 28.f, 100.f).CGColor, (id)RGB(28.f, 132.f, 242.f).CGColor] horizontal:NO];
}

- (void)viewAnimation:(ViewAnimation)viewAnimation animated:(BOOL)animated completion:(void (^)(void))completion {
    CGAffineTransform transform;
    CGFloat alpha;
    switch (viewAnimation) {
        case ViewAnimationFadeIn: {
            transform = CGAffineTransformIdentity;
            alpha = 1.f;
        }
            break;
        case ViewAnimationFadeOut: {
            transform = CGAffineTransformIdentity;
            alpha = 0.f;
        }
            break;
        case ViewAnimationZoomIn: {
            transform = CGAffineTransformIdentity;
            alpha = 1.f;
        }
            break;
        case ViewAnimationZoomOut: {
            transform = CGAffineTransformMakeScale(.64f, .64f);
            alpha = 0.f;
        }
            break;
    }
    if (animated) {
        [UIView animateWithDuration:.32f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _messageView.alpha = alpha;
            _messageView.transform = transform;
        } completion:nil];
        [UIView animateWithDuration:.32f delay:.32f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = alpha;
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
    [self viewAnimation:ViewAnimationZoomOut animated:YES completion:^{
        if (self.didCloseViewCompletion) {
            self.didCloseViewCompletion();
        }
    }];
}

@end
