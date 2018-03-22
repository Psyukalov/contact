//
//  HistoryTableViewCell.h
//  contact
//
//  Created by Vladimir Psyukalov on 22.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface HistoryTableViewCell : UITableViewCell

@property (assign, nonatomic) NSUInteger tokenCount;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *date;

@end
