//
//  AuthorizationViewController.h
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CViewController.h"


@interface AuthorizationViewController : CViewController

- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

@end
