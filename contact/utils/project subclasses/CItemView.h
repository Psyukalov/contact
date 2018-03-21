//
//  CItemView.h
//  contact
//
//  Created by Vladimir Psyukalov on 21.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CView.h"


@protocol CItemViewProtocol <NSObject>

@optional

- (void)playAnimation;
- (void)stopAnimation;

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

@end


@interface CItemView : CView <CItemViewProtocol>

@end
