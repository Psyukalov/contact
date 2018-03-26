//
//  ErrorMessageView.m
//  contact
//
//  Created by Vladimir Psyukalov on 26.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ErrorMessageView.h"


@interface ErrorMessageView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end


@implementation ErrorMessageView

#pragma mark - Class properties

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    _messageLabel.text = _message;
}

@end
