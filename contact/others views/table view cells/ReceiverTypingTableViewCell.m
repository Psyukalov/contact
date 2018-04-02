//
//  ReceiverTypingTableViewCell.m
//  contact
//
//  Created by Vladimir Psyukalov on 02.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ReceiverTypingTableViewCell.h"

#import "VPPointsActivityIndicatorView.h"


@interface ReceiverTypingTableViewCell ()

@property (weak, nonatomic) IBOutlet VPPointsActivityIndicatorView *pointsActivityIndicatorView;

@end


@implementation ReceiverTypingTableViewCell

#pragma mark - Overriding methods

- (void)awakeFromNib {
    [super awakeFromNib];
    [_pointsActivityIndicatorView playAnimation];
}

@end
