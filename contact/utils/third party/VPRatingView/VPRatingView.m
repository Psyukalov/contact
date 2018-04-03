//
//  VPRatingView.m
//
//
//  Created by Vladimir Psyukalov on 03.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "VPRatingView.h"


#define kDefaultPadding (6.f)
#define kDefaultMargin (0.f)


@interface VPRatingView ()

@property (strong, nonatomic) NSMutableArray<UIButton *> *buttons;

@end


@implementation VPRatingView

@synthesize rate = _rate;

#pragma mark - Class properties

- (void)setDefaultImage:(UIImage *)defaultImage {
    _defaultImage = defaultImage;
    [self image:_defaultImage controlState:UIControlStateNormal];
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    [self image:_selectedImage controlState:UIControlStateSelected];
}

- (void)setSize:(CGSize)size {
    _size = size;
    [self configurePosition];
}

- (void)setMargin:(CGFloat)margin {
    _margin = margin;
    [self configurePosition];
}

- (void)setPadding:(CGFloat)padding {
    _padding = padding;
    [self configurePosition];
}

- (void)setRate:(NSUInteger)rate {
    _rate = rate - 1;
    NSUInteger i = 0;
    for (UIButton *button in _buttons) {
        button.selected = i <= _rate;
        i++;
    }
}

- (NSUInteger)rate {
    return _rate + 1;
}

#pragma mark - Overriding methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Other methods

- (void)setup {
    _buttons = [NSMutableArray new];
    for (NSUInteger i = 0; i <= 4; i++) {
        UIButton *button = [UIButton new];
        button.tag = i;
        [button addTarget:self action:@selector(starButton_TUI:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_buttons addObject:button];
    }
    _padding = kDefaultPadding;
    _margin = kDefaultMargin;
    UIImage *defaultImage = [UIImage imageNamed:@"rating_default_button.png"];
    [self setSize:defaultImage.size];
    [self setDefaultImage:defaultImage];
    [self setSelectedImage:[UIImage imageNamed:@"rating_selected_button.png"]];
}

- (void)configurePosition {
    for (NSUInteger i = 0; i <= 4; i++) {
        _buttons[i].frame = CGRectMake(i * (_size.width + 2 * _padding + _margin), 0.f, _size.width + 2.f * _padding, _size.height + 2.f * _padding);
    }
}

- (void)image:(UIImage *)image controlState:(UIControlState)controlState {
    for (UIButton *button in _buttons) {
        [button setImage:image forState:controlState];
    }
}

#pragma mark - Actions

- (void)starButton_TUI:(UIButton *)sender {
    [self setRate:sender.tag + 1];
    if ([_delegate respondsToSelector:@selector(ratingView:didChangeRate:)]) {
        [_delegate ratingView:self didChangeRate:_rate];
    }
}

@end
