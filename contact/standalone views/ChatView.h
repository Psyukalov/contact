//
//  ChatView.h
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CView.h"

#import "TableView.h"

#import "Message.h"


@class ChatView;


@protocol ChatViewDelegate <NSObject>

@optional

- (void)chatView:(ChatView *)chatView didSendMessage:(Message *)message;

@end


@interface ChatView : CView <TableViewDelegate>

@property (assign, nonatomic) id<ChatViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray<Message *> *messages;

- (void)addMessage:(Message *)message;
- (void)removeMessage:(Message *)message;

- (void)receiverIsTypingText:(BOOL)isTypingText;

- (void)refresh;

@end
