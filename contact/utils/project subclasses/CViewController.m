//
//  CViewController.m
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CViewController.h"

#import "CDayTileOverlay.h"
#import "CNightTileOverlay.h"

#import "ScreenModeManager.h"


@interface CViewController () {
    BOOL canFocus;
}

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

- (void)mapViewHidden:(BOOL)hidden animated:(BOOL)animated {
    [self mapViewHidden:hidden animated:animated completion:nil];
}

- (void)mapViewHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGFloat alpha = hidden ? 0.f : 1.f;
    if (animated) {
        [UIView animateWithDuration:.64f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _mapView.alpha = alpha;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        _mapView.alpha = alpha;
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
    NSLog(@"Accelerometer update with acceleration components: %1.4f, %1.4f, %1.4f;", acceleration.x, acceleration.y, acceleration.z);
}

- (void)toggleBlurView:(BOOL)on {
    [self toggleBlurView:on animated:YES];
}

- (void)toggleBlurView:(BOOL)on animated:(BOOL)animated {
    [self toggleBlurView:on animated:animated aboveView:nil completion:nil];
}

- (void)toggleBlurView:(BOOL)on animated:(BOOL)animated completion:(void (^)(void))completion {
    [self toggleBlurView:on animated:animated aboveView:nil completion:completion];
}

- (void)toggleBlurView:(BOOL)on animated:(BOOL)animated aboveView:(UIView *)aboveView completion:(void (^)(void))completion {
    if (on) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.alpha = 0.f;
        if (!aboveView) {
            aboveView = _baseGradientLayer_1_ImageView;
        }
        [self.contentView insertSubview:visualEffectView aboveSubview:aboveView];
        [self.contentView addConstraintsWithView:visualEffectView customInsert:YES];
        if (animated) {
            [UIView animate:^{
                visualEffectView.alpha = 1.f;
            } completion:^{
                if (completion) {
                    completion();
                }
            }];
        } else {
            visualEffectView.alpha = 1.f;
            if (completion) {
                completion();
            }
        }
    } else {
        UIView *visualEffectView;
        for (UIView *view in self.contentView.subviews) {
            if ([view isKindOfClass:[UIVisualEffectView class]]) {
                visualEffectView = view;
                break;
            }
        }
        if (!visualEffectView) {
            if (completion) {
                completion();
            }
            return;
        }
        if (animated) {
            [UIView animate:^{
                visualEffectView.alpha = 0.f;
            } completion:^{
                [visualEffectView removeFromSuperview];
                if (completion) {
                    completion();
                }
            }];
        } else {
            [visualEffectView removeFromSuperview];
            if (completion) {
                completion();
            }
        }
    }
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
    canFocus = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenModeChangeNotificationName) name:kScreenModeChangeNotificationName object:nil];
    if (_neededAccelerometerUpdates) {
        _motionManager = [CMMotionManager new];
        _motionManager.accelerometerUpdateInterval = .08f;
    }
    [[ScreenModeManager shared] applyScreenMode];
    [self gradientLayersHidden:YES animated:NO];
    [self mapViewHidden:YES animated:NO];
    _basePatternImageView.layer.zPosition = -1024.f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self gradientLayersHidden:!_neededGradientImageViews animated:_isAnimated];
}

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration completion:(void (^)(void))completion {
    [super keyboardWillShow:show height:height duration:duration completion:nil];
    [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _scrollView.contentInset = show ? UIEdgeInsetsMake(0.f, 0.f, height, 0.f) : UIEdgeInsetsZero;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)screenModeChangeNotificationName {
    ScreenModeManager *manager = [ScreenModeManager shared];
    for (id<MKOverlay> tileOverlay in _mapView.overlays) {
        if ([tileOverlay isKindOfClass:[TileOverlay class]]) {
            [_mapView removeOverlay:tileOverlay];
        }
    }
    [_mapView addOverlay:manager.isScreenModeDay ? [CDayTileOverlay tileOverlay] : [CNightTileOverlay tileOverlay]];
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    BOOL condition = [overlay isKindOfClass:[TileOverlay class]];
    return condition ? [[MKTileOverlayRenderer alloc] initWithTileOverlay:overlay] : [[MKOverlayRenderer alloc] initWithOverlay:overlay];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (canFocus) {
        CGFloat delta = .16f;
        MKCoordinateSpan span = MKCoordinateSpanMake(delta, delta);
        MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, span);
        [_mapView setRegion:region animated:YES];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        static NSString *userLocationReuseIdentifier = @"user_location_reuse_identifier";
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userLocationReuseIdentifier];
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:@"pin_user_location_image"];
        return annotationView;
    } else {
        return nil;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // TODO:
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    // TODO:
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    canFocus = NO;
}

@end
