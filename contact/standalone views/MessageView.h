//
//  MessageView.h
//  contact
//
//  Created by Vladimir Psyukalov on 26.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CView.h"


#define kDefaultAutoDiclineTime (10)


@interface MessageView : CView

@property (weak, nonatomic) IBOutlet UIView *messageView;

- (void)close;

@end
