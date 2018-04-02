//
//  ReceiverMessageTableViewCell.m
//  contact
//
//  Created by Vladimir Psyukalov on 28.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ReceiverMessageTableViewCell.h"

#import "UIView+Custom.h"


@implementation ReceiverMessageTableViewCell

#pragma mark - Overriding methods

- (void)show {
    self.transform = CGAffineTransformMakeTranslation(-32.f, 0.f);
    self.alpha = 0.f;
    [UIView animate:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.f;
    } completion:nil duration:.64f];
}

@end
