//
//  CViewController.m
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CViewController.h"

#import "ScreenModeManager.h"


@interface CViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *basePatternImageView;
@property (weak, nonatomic) IBOutlet UIImageView *baseGradientLayer_0_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *baseGradientLayer_1_ImageView;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end


@implementation CViewController

#pragma mark - Class properties

- (void)setNeeded3DEffect:(BOOL)needed3DEffect {
    [self setNeeded3DEffect:needed3DEffect animated:YES];
}

#pragma mark - Class methods

- (void)gradientLayersHidden:(BOOL)hidden animated:(BOOL)animated {
    [self gradientLayersHidden:hidden animated:animated completion:nil];
}

- (void)gradientLayersHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGFloat alpha = hidden ? 0.f : 1.f;
    if (animated) {
        [UIView animateWithDuration:.64f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _baseGradientLayer_0_ImageView.alpha = alpha;
            _baseGradientLayer_1_ImageView.alpha = alpha;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        _baseGradientLayer_0_ImageView.alpha = alpha;
        _baseGradientLayer_1_ImageView.alpha = alpha;
        if (completion) {
            completion();
        }
    }
}

- (void)startAccelerometerUpdates {
    if (!_motionManager.accelerometerAvailable || _motionManager.accelerometerActive) {
        return;
    }
    [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        if (!error && accelerometerData) {
            [self accelerometerUpdateWithAcceleration:accelerometerData.acceleration];
        }
    }];
}

- (void)stopAccelerometerUpdates {
    [_motionManager stopAccelerometerUpdates];
}

- (void)accelerometerUpdateWithAcceleration:(CMAcceleration)acceleration {
//    NSLog(@"Accelerometer update with acceleration components: %1.4f, %1.4f, %1.4f;", acceleration.x, acceleration.y, acceleration.z);
}

- (void)setNeeded3DEffect:(BOOL)needed3DEffect animated:(BOOL)animated {
    _needed3DEffect = needed3DEffect;
    CATransform3D transform = CATransform3DIdentity;
    if (_needed3DEffect) {
        transform.m34 = 1.f / 1024.f;
        transform = CATransform3DRotate(transform, DEGREES_TO_RADIANS(-45.f), 1.f, 0.f, 0.f);
    }
    if (animated) {
        [UIView animateWithDuration:.64f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _basePatternImageView.layer.transform = transform;
        } completion:nil];
    } else {
        _basePatternImageView.layer.transform = transform;
    }
}

#pragma mark - Overriding methods

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_neededAccelerometerUpdates) {
        _motionManager = [CMMotionManager new];
        _motionManager.accelerometerUpdateInterval = .08f;
    }
    [[ScreenModeManager shared] applyScreenMode];
    [self gradientLayersHidden:YES animated:NO];
    _basePatternImageView.layer.zPosition = -1024.f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self gradientLayersHidden:!_neededGradientImageViews animated:_isAnimated];
}

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration {
    [super keyboardWillShow:show height:height duration:duration];
    [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _scrollView.contentOffset = show ? CGPointMake(0.f, height) : CGPointZero;
        _scrollView.contentInset = show ? UIEdgeInsetsMake(0.f, 0.f, height, 0.f) : UIEdgeInsetsZero;
    } completion:nil];
}

@end
