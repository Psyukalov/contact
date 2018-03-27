//
//  OwnerMessageTableViewCell.m
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "OwnerMessageTableViewCell.h"

#import "UIView+Custom.h"


@interface OwnerMessageTableViewCell ()

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

#pragma mark - Overriding methods

- (void)awakeFromNib {
    [super awakeFromNib];
    [_roundedView cornerRadius:16.f];
}

@end
