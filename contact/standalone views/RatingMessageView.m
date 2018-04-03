//
//  RatingMessageView.m
//  contact
//
//  Created by Vladimir Psyukalov on 03.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "RatingMessageView.h"

#import "VPRatingView.h"


@interface RatingMessageView ()

@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (weak, nonatomic) IBOutlet UILabel *tokensLabel;
@property (weak, nonatomic) IBOutlet UILabel *tokensCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (weak, nonatomic) IBOutlet VPRatingView *ratingView;

@end


@implementation RatingMessageView

#pragma mark - Class properties

- (void)setTokensCount:(NSUInteger)tokensCount {
    _tokensCount = tokensCount;
    _tokensCountLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)_tokensCount];
}

- (NSUInteger)rate {
    return _ratingView.rate;
}

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _ratingView.rate = 3;
    _successLabel.text = LOCALIZE(@"rating_mv_label_0");
    _tokensLabel.text = LOCALIZE(@"rating_mv_label_1");
    _rateLabel.text = LOCALIZE(@"rating_mv_label_2");
}

@end
