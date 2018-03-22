//
//  HistoryTableViewCell.m
//  contact
//
//  Created by Vladimir Psyukalov on 22.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "HistoryTableViewCell.h"


@interface HistoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *tokensCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end


@implementation HistoryTableViewCell

#pragma mark - Class properties

- (void)setTokenCount:(NSUInteger)tokenCount {
    _tokenCount = tokenCount;
    _tokensCountLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)_tokenCount];
}

- (void)setName:(NSString *)name {
    _name = name;
    _nameLabel.text = _name;
}

- (void)setDate:(NSString *)date {
    _date = date;
    _dateLabel.text = _date;
}

@end
