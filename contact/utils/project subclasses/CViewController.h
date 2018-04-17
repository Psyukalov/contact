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

#import "UIView+Custom.h"

#import "MapView.h"

#import "ErrorMessageView.h"


typedef void(^CViewControllerCompletion)(void);


@protocol CViewControllerProtocol <NSObject>

@optional

- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

@end


IB_DESIGNABLE

@interface CViewController : ViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet MapView *mapView;

@property (assign, nonatomic) IBInspectable BOOL neededGradientImageViews;
@property (assign, nonatomic) IBInspectable BOOL isAnimated;
@property (assign, nonatomic) IBInspectable BOOL neededAccelerometerUpdates;

@property (assign, nonatomic) BOOL needed3DEffect;

@property (copy, nonatomic) CViewControllerCompletion didCloseViewControllerCompletion;

- (void)gradientLayersHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)gradientLayersHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)mapViewHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)mapViewHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)startAccelerometerUpdates;
- (void)stopAccelerometerUpdates;

- (void)accelerometerUpdateWithAcceleration:(CMAcceleration)acceleration;

- (void)setNeeded3DEffect:(BOOL)needed3DEffect animated:(BOOL)animated;

- (void)toggleBlurView:(BOOL)on;
- (void)toggleBlurView:(BOOL)on animated:(BOOL)animated;
- (void)toggleBlurView:(BOOL)on animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)toggleBlurView:(BOOL)on animated:(BOOL)animated aboveView:(UIView *)aboveView completion:(void (^)(void))completion;

@end
