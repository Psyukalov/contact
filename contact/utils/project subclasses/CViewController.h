//
//  CViewController.h
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <CoreMotion/CoreMotion.h>


#import "ViewController.h"

#import "Macros.h"

// TODO:


typedef void(^CViewControllerCompletion)(void);


@protocol CViewControllerProtocol <NSObject>

@optional

- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

@end


IB_DESIGNABLE

@interface CViewController : ViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (assign, nonatomic) IBInspectable BOOL neededGradientImageViews;
@property (assign, nonatomic) IBInspectable BOOL isAnimated;
@property (assign, nonatomic) IBInspectable BOOL neededAccelerometerUpdates;

@property (assign, nonatomic) BOOL needed3DEffect;

@property (copy, nonatomic) CViewControllerCompletion didCloseViewControllerCompletion;

- (void)gradientLayersHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)gradientLayersHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)startAccelerometerUpdates;
- (void)stopAccelerometerUpdates;

- (void)accelerometerUpdateWithAcceleration:(CMAcceleration)acceleration;

- (void)setNeeded3DEffect:(BOOL)needed3DEffect animated:(BOOL)animated;

@end
