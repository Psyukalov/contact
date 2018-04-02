//
//  OwnerMessageTableViewCell.h
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface OwnerMessageTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *date;

@property (assign, nonatomic) BOOL isDelivered;
@property (assign, nonatomic) BOOL isNightMode;
@property (assign, nonatomic) BOOL neededNightMode;

- (void)animate;

@end
