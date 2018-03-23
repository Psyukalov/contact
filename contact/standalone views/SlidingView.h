//
//  SlidingView.h
//  contact
//
//  Created by Vladimir Psyukalov on 23.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CView.h"


IB_DESIGNABLE

@interface SlidingView : CView <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *unhideHeightLC;

@property (assign, nonatomic) IBInspectable CGFloat deltaBorder;

@property (assign, nonatomic) CGFloat topBorder;
@property (assign, nonatomic) CGFloat bottomBorder;

@property (assign, nonatomic) BOOL isOpen;

- (void)setIsOpen:(BOOL)isOpen animated:(BOOL)animated;
- (void)setIsOpen:(BOOL)isOpen animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)interfaceWithPercent:(CGFloat)percent;

@end
