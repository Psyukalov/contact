//
//  CView.h
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "View.h"

#import "Macros.h"

#import "UIView+Custom.h"


typedef NS_ENUM(NSUInteger, ViewDirection) {
    ViewDirectionTop = 0,
    ViewDirectionRight,
    ViewDirectionBottom,
    ViewDirectionLeft,
    ViewDirectionCenter
};

typedef NS_ENUM(NSUInteger, ViewAnimation) {
    ViewAnimationFadeIn = 0,
    ViewAnimationFadeOut,
    ViewAnimationZoomIn,
    ViewAnimationZoomOut
};

typedef void(^CViewCompletion)(void);


IB_DESIGNABLE

@interface CView : View

@property (assign, nonatomic) IBInspectable CGFloat parallaxRadius;

@property (assign, nonatomic) CGPoint parallaxPoint;

@property (assign, nonatomic) BOOL needed3DEffect;

@property (assign, nonatomic) CGRect keyboardFrame;

@property (copy, nonatomic) CViewCompletion didCloseViewCompletion;

- (void)viewDirection:(ViewDirection)viewDirection animated:(BOOL)animated;
- (void)viewDirection:(ViewDirection)viewDirection animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)viewAnimation:(ViewAnimation)viewAnimation animated:(BOOL)animated;
- (void)viewAnimation:(ViewAnimation)viewAnimation animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)setNeeded3DEffect:(BOOL)needed3DEffect animated:(BOOL)animated;

@end
