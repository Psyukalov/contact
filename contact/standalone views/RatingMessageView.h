//
//  RatingMessageView.h
//  contact
//
//  Created by Vladimir Psyukalov on 03.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MessageView.h"


@interface RatingMessageView : MessageView

@property (assign, nonatomic) NSUInteger tokensCount;
@property (assign, nonatomic) NSUInteger rate;

@end
