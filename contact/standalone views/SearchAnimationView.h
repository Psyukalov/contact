//
//  SearchAnimationView.h
//  contact
//
//  Created by Vladimir Psyukalov on 19.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CView.h"


@interface SearchAnimationView : CView

- (void)logotypeHidden:(BOOL)hidden;
- (void)logotypeHidden:(BOOL)hidden completion:(void (^)(void))completion;

- (void)play;
- (void)stop;

@end
