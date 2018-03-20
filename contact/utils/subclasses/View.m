//
//  View.m
//
//
//  Created by Vladimir Psyukalov on 01.10.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "View.h"


@implementation View

#pragma mark - Class methods

- (void)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
    _contentView = (UIView *)[nib instantiateWithOwner:self options:nil].firstObject;
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = _contentView.backgroundColor;
    [self addSubview:_contentView];
    NSArray *attributes = @[@(NSLayoutAttributeLeft), @(NSLayoutAttributeTop), @(NSLayoutAttributeRight), @(NSLayoutAttributeBottom)];
    for (NSNumber *attribute in attributes) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:[attribute unsignedIntegerValue] relatedBy:NSLayoutRelationEqual toItem:self attribute:[attribute unsignedIntegerValue] multiplier:1.f constant:0.f]];
    }
}

#pragma mark - Overriding methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViewFromNib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadViewFromNib];
    }
    return self;
}

@end
