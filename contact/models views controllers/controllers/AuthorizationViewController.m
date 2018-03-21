//
//  AuthorizationViewController.m
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "AuthorizationViewController.h"

#import "AuthorizationView.h"
#import "RegistrationView.h"
#import "ManualView.h"

#import "ScreenModeManager.h"


@interface AuthorizationViewController () <AuthorizationViewDelegate, RegistrationViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *instructionButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet AuthorizationView *authorizationView;

@property (weak, nonatomic) IBOutlet RegistrationView *registrationView;

@property (strong, nonatomic) CView *customView;

@end


@implementation AuthorizationViewController

#pragma mark - Overriding methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [_instructionButton cornerRadius:.5f * _instructionButton.frame.size.height];
    [_instructionButton setTitle:LOCALIZE(@"avc_button_0") forState:UIControlStateNormal];
    [self interfaceHidden:YES animated:NO];
    [_authorizationView viewDirection:ViewDirectionBottom animated:NO];
    [_registrationView viewDirection:ViewDirectionBottom animated:NO];
    _authorizationView.delegate = self;
    _registrationView.delegate = self;
    _registrationView.didCloseViewCompletion = ^{
        [_authorizationView viewDirection:ViewDirectionCenter animated:YES];
        [_registrationView viewDirection:ViewDirectionBottom animated:YES];
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self interfaceHidden:NO animated:YES completion:^{
        [_authorizationView viewDirection:ViewDirectionCenter animated:YES];
    }];
}

- (void)accelerometerUpdateWithAcceleration:(CMAcceleration)acceleration {
    [super accelerometerUpdateWithAcceleration:acceleration];
    _customView.parallaxPoint = CGPointMake(acceleration.x, acceleration.y);
}

#pragma mark - Class methods

- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated {
    [self interfaceHidden:hidden animated:animated completion:nil];
}
- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGFloat alpha = hidden ? 0.f : 1.f;
    if (animated) {
        [UIView animate:^{
            _instructionButton.alpha = alpha;
            _imageView.alpha = alpha;
        } completion:^{
            if (completion) {
                completion();
            }
        }];
    } else {
        _instructionButton.alpha = alpha;
        _imageView.alpha = alpha;
        if (completion) {
            completion();
        }
    }
}

#pragma mark - AuthorizationViewDelegate

- (void)didSelectAuthorizationAction:(AuthorizationAction)authorizationAction {
    switch (authorizationAction) {
        case AuthorizationActionLogin: {
            // TODO:
            [self interfaceHidden:YES animated:YES completion:^{
                [_authorizationView viewDirection:ViewDirectionBottom animated:YES completion:^{
                    [self gradientLayersHidden:YES animated:YES completion:^{
                        if (self.didCloseViewControllerCompletion) {
                            self.didCloseViewControllerCompletion();
                        }
                    }];
                }];
            }];
        }
            break;
        case AuthorizationActionFacebook: {
            // TODO:
        }
            break;
        case AuthorizationActionVKontakte: {
            // TODO:
        }
            break;
        case AuthorizationActionForgotPassword: {
            // TODO:
        }
            break;
        case AuthorizationActionSignUp: {
            [_authorizationView viewDirection:ViewDirectionTop animated:YES];
            [_registrationView viewDirection:ViewDirectionCenter animated:YES];
        }
            break;
    }
}

#pragma mark - RegistrationViewDelegate

- (void)didSelectRegistrationAction:(RegistrationAction)registrationAction {
    switch (registrationAction) {
        case RegistrationActionSignUp: {
            // TODO:
        }
            break;
    }
}

#pragma mark - Actions

- (IBAction)instructionButton_TUI:(UIButton *)sender {
    [self startAccelerometerUpdates];
    ManualView *manualView = [[ManualView alloc] initWithFrame:self.view.bounds];
    _customView = manualView;
    [self.view addSubview:manualView];
    [manualView viewAnimation:ViewAnimationFadeOut animated:NO];
    [manualView viewAnimation:ViewAnimationFadeIn animated:YES];
    __weak ManualView *weakManualView = manualView;
    manualView.didCloseViewCompletion = ^{
        [self stopAccelerometerUpdates];
        _customView = nil;
        [weakManualView viewAnimation:ViewAnimationFadeOut animated:YES completion:^{
            [weakManualView removeFromSuperview];
        }];
    };
}

@end
