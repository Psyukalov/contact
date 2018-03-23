//
//  EditProfileSlidingView.m
//  contact
//
//  Created by Vladimir Psyukalov on 23.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "EditProfileSlidingView.h"


@interface EditProfileSlidingView () {
    BOOL closed;
}

@end


@implementation EditProfileSlidingView

#pragma mark - Class properties

#pragma mark - Class methods

#pragma mark - Overriding properties

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [self setIsOpen:YES animated:NO];
}

- (void)interfaceWithPercent:(CGFloat)percent {
    [super interfaceWithPercent:percent];
    if (!closed && percent == 0.f && self.didCloseViewCompletion) {
        closed = YES;
        self.didCloseViewCompletion();
        return;
    }
}

#pragma mark - UIScrollViewDelegate

#pragma mark - Other methods

#pragma mark - Actions

@end
