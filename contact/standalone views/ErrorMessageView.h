//
//  ErrorMessageView.h
//  contact
//
//  Created by Vladimir Psyukalov on 26.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MessageView.h"


@interface ErrorMessageView : MessageView

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;

@end
