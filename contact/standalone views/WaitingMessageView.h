//
//  WaitingMessageView.h
//  contact
//
//  Created by Vladimir Psyukalov on 03.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MessageView.h"


@interface WaitingMessageView : MessageView

@property (assign, nonatomic) NSUInteger autoDeclineTime;

@end
