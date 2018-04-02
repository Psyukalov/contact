//
//  OwnerMessageTableViewCell.m
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "OwnerMessageTableViewCell.h"

#import "Macros.h"

#import "UIView+Custom.h"

#import "SMView.h"
#import "SMLabel.h"


@interface OwnerMessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *cornerView;
@property (weak, nonatomic) IBOutlet UIView *roundedView;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageview;

@end


@implementation OwnerMessageTableViewCell

#pragma mark - Class properties

- (void)setMessage:(NSString *)message {
    _message = message;
    _messageLabel.text = _message;
}

- (void)setDate:(NSString *)date {
    _date = date;
    _dateLabel.text = _date;
}

- (void)setIsDelivered:(BOOL)isDelivered {
    _isDelivered = isDelivered;
    _iconImageview.highlighted = _isDelivered;
}

- (void)setIsNightMode:(BOOL)isNightMode {
    _isNightMode = isNightMode;
    if (_neededNightMode) {
        UIColor *nightModeColor = RGB(62.f, 64.f, 122.f);
        UIColor *dayModeColor = RGB(255.f, 255.f, 255.f);
        _cornerView.backgroundColor = _isNightMode ? nightModeColor : dayModeColor;
        _roundedView.backgroundColor = _isNightMode ? nightModeColor : dayModeColor;
        nightModeColor = RGB(255.f, 255.f, 255.f);
        dayModeColor = RGB(34.f, 34.f, 40.f);
        _messageLabel.textColor = _isNightMode ? nightModeColor : dayModeColor;
        _dateLabel.textColor = _isNightMode ? nightModeColor : dayModeColor;
    }
}

#pragma mark - Class methods

- (void)show {
    self.transform = CGAffineTransformMakeTranslation(32.f, 0.f);
    self.alpha = 0.f;
    [UIView animate:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1.f;
    } completion:nil duration:.64f];
}

#pragma mark - Overriding methods

- (void)awakeFromNib {
    [super awakeFromNib];
    [_roundedView cornerRadius:16.f];
}

@end
