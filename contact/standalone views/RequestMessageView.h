//
//  RequestMessageView.h
//  contact
//
//  Created by Vladimir Psyukalov on 03.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MessageView.h"


@class RequestMessageView;


@protocol RequestMessageViewDelegate <NSObject>

@optional

- (void)messageViewDidSelectConnect:(RequestMessageView *)messageView;

@end


@interface RequestMessageView : MessageView

@property (weak, nonatomic) id<RequestMessageViewDelegate> delegate;

@property (strong, nonatomic) NSString *name;

@property (assign, nonatomic) NSUInteger age;
@property (assign, nonatomic) NSUInteger autoDeclineTime;

@property (assign, nonatomic) CGFloat distance; // Meters;

@end
