//
//  ConversationView.h
//  contact
//
//  Created by Vladimir Psyukalov on 27.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CView.h"

#import "ChatView.h"


@interface ConversationView : CView

@property (weak, nonatomic) IBOutlet ChatView *chatView;

@end
