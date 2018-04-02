//
//  Message.h
//
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface Message : NSObject

@property (assign, nonatomic) NSUInteger identifier;

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *date;

@property (assign, nonatomic) BOOL isOwner;
@property (assign, nonatomic) BOOL isDelivered;
@property (assign, nonatomic) BOOL isTypingNow;

@end
