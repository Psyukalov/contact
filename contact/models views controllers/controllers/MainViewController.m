//
//  MainViewController.m
//  contact
//
//  Created by Vladimir Psyukalov on 19.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MainViewController.h"

#import "SearchAnimationView.h"
#import "ProfileSlidingView.h"
#import "HistoryView.h"
#import "EditProfileSlidingView.h"
#import "AboutContactView.h"
#import "ConversationView.h"

#import "AuthorizationViewController.h"

#import "LocationManager.h"

// TODO:

#import "QRCodeView.h"
#import "QRScanView.h"
#import "RequestMessageView.h"
#import "WaitingMessageView.h"
#import "RatingMessageView.h"


@interface MainViewController () <ProfileSlidingViewDelegate>

@property (weak, nonatomic) IBOutlet SearchAnimationView *searchAnimationView;

@property (weak, nonatomic) IBOutlet ProfileSlidingView *profileSlidingView;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) CView *customView;

@property (strong, nonatomic) ConversationView *conversationView;

// TODO:

@property (weak, nonatomic) IBOutlet QRCodeView *generatingQRView;
@property (weak, nonatomic) IBOutlet UIView *testFuncView;

@end


@implementation MainViewController {
    BOOL value;
}

#pragma mark - Class methods

- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated {
    [self interfaceHidden:hidden animated:animated completion:nil];
}

- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGFloat height = 94.f / 812.f * HEIGHT + 18.f;
    CGAffineTransform transform = hidden ? CGAffineTransformMakeTranslation(0.f, height) : CGAffineTransformIdentity;
    if (animated) {
        if (!hidden) {
            _profileSlidingView.hidden = NO;
        }
        [UIView animate:^{
            _profileSlidingView.transform = transform;
        } completion:^{
            if (hidden) {
                _profileSlidingView.hidden = YES;
            }
            if (completion) {
                completion();
            }
        } duration:.64f];
    } else {
        _profileSlidingView.transform = transform;
        _profileSlidingView.hidden = hidden;
        if (completion) {
            completion();
        }
    }
}

#pragma mark - Overriding methods

- (void)viewDidLoad {
    [super viewDidLoad];
    LocationOptions options = LocationOptionsMake(LocationUpdateTypeLocation, kCLDistanceFilterNone, kCLLocationAccuracyBest, 0.f);
    LocationManager *locationManager = [LocationManager sharedWithOptions:options];
    [locationManager requestAuthorization];
    [locationManager startUpdate];
    _profileSlidingView.delegate = self;
    [_searchAnimationView viewAnimation:ViewAnimationZoomOut animated:NO];
    [self interfaceHidden:YES animated:NO];
    [self searchButtonHidden:YES animated:NO completion:nil];
    [_searchButton setTitle:LOCALIZE(@"mvc_button_0") forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileSlidingView_TUI)];
    [_profileSlidingView addGestureRecognizer:tapGR];
    // TODO:
    [_generatingQRView viewAnimation:ViewAnimationFadeOut animated:NO];
    //
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self performSelector:@selector(showMap) withObject:nil afterDelay:3.2f];
    BOOL authorized;
    // TODO:
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    authorized = [userDefaults boolForKey:@"auth"];
    //
    if (!authorized) {
        [self actionLogOut];
        return;
    }
    [self startAnimations];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration completion:(void (^)(void))completion {
    if (_conversationView) {
        [_conversationView.chatView keyboardWillShow:show height:height duration:duration];
    } else {
        [super keyboardWillShow:show height:height duration:duration completion:nil];
        _profileSlidingView.isScrollEnabled = !show;
    }
}

- (void)accelerometerUpdateWithAcceleration:(CMAcceleration)acceleration {
    [super accelerometerUpdateWithAcceleration:acceleration];
    _customView.parallaxPoint = CGPointMake(acceleration.x, acceleration.y);
}

#pragma mark - ProfileSlidingViewDelegate

- (void)profileView:(ProfileSlidingView *)profileView didSelectProfileAction:(ProfileAction)profileAction {
    switch (profileAction) {
        case ProfileActionShowHistory: {
            HistoryView *historyView = [[HistoryView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:historyView];
            [historyView viewDirection:ViewDirectionBottom animated:NO];
            __weak MainViewController *weakSelf = self;
            [profileView setIsOpen:NO animated:YES completion:^{
                [weakSelf interfaceHidden:YES animated:YES completion:^{
                    [weakSelf.searchAnimationView viewAnimation:ViewAnimationZoomOut animated:YES completion:^{
                        [weakSelf.searchAnimationView stop];
                        [weakSelf gradientLayersHidden:NO animated:YES completion:^{
                            [historyView viewDirection:ViewDirectionCenter animated:YES];
                        }];
                    }];
                }];
            }];
            __weak HistoryView *weakHistoryView = historyView;
            historyView.didCloseViewCompletion = ^{
                [weakHistoryView viewDirection:ViewDirectionBottom animated:YES completion:^{
                    [weakHistoryView removeFromSuperview];
                    [self gradientLayersHidden:YES animated:YES completion:^{
                        [_searchAnimationView play];
                        [_searchAnimationView viewAnimation:ViewAnimationZoomIn animated:YES completion:^{
                            [self interfaceHidden:NO animated:YES completion:^{
                                [profileView setIsOpen:YES];
                            }];
                        }];
                    }];
                }];
            };
        }
            break;
        case ProfileActionEditProfile: {
            EditProfileSlidingView *editProfileSlidingView = [[EditProfileSlidingView alloc] initWithFrame:self.view.bounds];
            [self.contentView addSubview:editProfileSlidingView];
            [editProfileSlidingView viewDirection:ViewDirectionBottom animated:NO];
            __weak MainViewController *weakSelf = self;
            [profileView setIsOpen:NO animated:YES completion:^{
                [weakSelf interfaceHidden:YES animated:YES completion:^{
                    [weakSelf.searchAnimationView logotypeHidden:YES completion:^{
                        [weakSelf toggleBlurView:YES animated:YES aboveView:weakSelf.searchAnimationView completion:^{
                            [editProfileSlidingView viewDirection:ViewDirectionCenter animated:YES];
                        }];
                    }];
                }];
            }];
            __weak EditProfileSlidingView *weakEditProfileView = editProfileSlidingView;
            editProfileSlidingView.didCloseViewCompletion = ^{
                [weakEditProfileView viewAnimation:ViewAnimationFadeOut animated:YES completion:^{
                    [weakEditProfileView removeFromSuperview];
                    [self toggleBlurView:NO animated:YES completion:^{
                        [_searchAnimationView logotypeHidden:NO completion:^{
                            [self interfaceHidden:NO animated:YES completion:^{
                                [profileView setIsOpen:YES];
                            }];
                        }];
                    }];
                }];
            };
        }
            break;
        case ProfileActionLogOut: {
            __weak MainViewController *weakSelf = self;
            [self mapViewHidden:YES animated:NO completion:^{
                [profileView setIsOpen:NO animated:YES completion:^{
                    [weakSelf interfaceHidden:YES animated:YES completion:^{
                        [weakSelf.searchAnimationView viewAnimation:ViewAnimationZoomOut animated:YES completion:^{
                            [weakSelf.searchAnimationView stop];
                            [weakSelf actionLogOut];
                        }];
                    }];
                }];
            }];
        }
            break;
        case ProfileActionAboutContact: {
            [self startAccelerometerUpdates];
            AboutContactView *aboutContactView = [[AboutContactView alloc] initWithFrame:self.view.bounds];
            _customView = aboutContactView;
            [self.view addSubview:aboutContactView];
            [aboutContactView viewAnimation:ViewAnimationFadeOut animated:NO];
            [aboutContactView viewAnimation:ViewAnimationFadeIn animated:YES];
            __weak AboutContactView *weakAboutContactView = aboutContactView;
            aboutContactView.didCloseViewCompletion = ^{
                [self stopAccelerometerUpdates];
                _customView = nil;
                [weakAboutContactView viewAnimation:ViewAnimationFadeOut animated:YES completion:^{
                    [weakAboutContactView removeFromSuperview];
                }];
            };
        }
            break;
    }
}

#pragma mark - Other methods

- (void)actionLogOut {
    // TODO:
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"auth"];
    [userDefaults synchronize];
    //
    AuthorizationViewController *authorizationVC = [AuthorizationViewController new];
    authorizationVC.view.frame = self.view.bounds;
    __weak AuthorizationViewController *weakAuthorizationVC = authorizationVC;
    authorizationVC.didCloseViewControllerCompletion = ^{
        // TODO:
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"auth"];
        [userDefaults synchronize];
        //
        [weakAuthorizationVC.view removeFromSuperview];
        [self mapViewHidden:NO animated:YES completion:^{
            [self startAnimations];
        }];
    };
    [self.view addSubview:authorizationVC.view];
}

- (void)startAnimations {
    [_searchAnimationView viewAnimation:ViewAnimationZoomIn animated:YES completion:^{
        [self interfaceHidden:NO animated:YES completion:^{
            [_searchAnimationView play];
        }];
    }];
}

- (void)applicationWillEnterForeground {
    [_searchAnimationView play];
}

- (void)showMap {
    [self mapViewHidden:NO animated:YES];
}

- (void)searchButtonHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion{
    CGFloat alpha = hidden ? 0.f : 1.f;
    if (animated) {
        [UIView animate:^{
            _searchButton.alpha = alpha;
        } completion:^{
            if (completion) {
                completion();
            }
        } duration:.64f];
    } else {
        _searchButton.alpha = alpha;
        if (completion) {
            completion();
        }
    }
}

#pragma mark - Actios

- (void)profileSlidingView_TUI {
    if (!_profileSlidingView.isOpen) {
        [self interfaceHidden:YES animated:YES completion:^{
            [self gradientLayersHidden:YES animated:YES completion:^{
                [_searchAnimationView viewAnimation:ViewAnimationZoomOut animated:YES completion:^{
                    [self searchButtonHidden:NO animated:YES completion:nil];
                }];
            }];
        }];
    }
}

- (IBAction)searchButton_TUI:(UIButton *)sender {
    [self searchButtonHidden:YES animated:YES completion:^{
        [_searchAnimationView viewAnimation:ViewAnimationZoomIn animated:YES completion:^{
            [self gradientLayersHidden:NO animated:YES completion:^{
                [self interfaceHidden:NO animated:YES];
            }];
        }];
    }];
}

#pragma mark - Test

- (IBAction)conv:(UIButton *)sender {
    _testFuncView.hidden = YES;
    ConversationView *conversationView = [[ConversationView alloc] initWithFrame:self.view.bounds];
    [self.contentView addSubview:conversationView];
    [conversationView viewAnimation:ViewAnimationFadeOut animated:NO];
    __weak ConversationView *weakConversationView = conversationView;
    conversationView.didCloseViewCompletion = ^{
        [weakConversationView viewAnimation:ViewAnimationFadeOut animated:YES completion:^{
            [weakConversationView removeFromSuperview];
            _conversationView = nil;
            [self gradientLayersHidden:YES animated:YES completion:^{
                [_searchAnimationView viewAnimation:ViewAnimationZoomIn animated:YES completion:^{
                    [self interfaceHidden:NO animated:YES completion:^{
                        _testFuncView.hidden = NO;
                    }];
                }];
            }];
        }];
    };
    [_profileSlidingView setIsOpen:NO animated:YES completion:^{
        [self interfaceHidden:YES animated:YES completion:^{
            [_searchAnimationView viewAnimation:ViewAnimationZoomOut animated:YES completion:^{
                [self gradientLayersHidden:NO animated:YES completion:^{
                    [conversationView viewAnimation:ViewAnimationFadeIn animated:YES];
                }];
            }];
        }];
    }];
    _conversationView = conversationView;
}

- (IBAction)message_tui:(UIButton *)sender {
    ErrorMessageView *errorMV = [ErrorMessageView new];
    errorMV.title = @"Error";
    errorMV.message = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus pharetra lacus vitae velit volutpat tempor. Vestibulum eget rutrum lorem. Etiam luctus volutpat nisi, at aliquam risus varius quis.";
    errorMV.didCloseViewCompletion = ^{
        NSLog(@"Error message view did close;");
    };
    [errorMV viewAnimation:ViewAnimationZoomIn animated:YES completion:^{
        NSLog(@"Showed error message view;");
    }];
}

- (IBAction)generatingQR_tui:(UIButton *)sender {
    [_generatingQRView viewAnimation:ViewAnimationFadeIn animated:YES];
}

- (IBAction)readingQR_tui:(UIButton *)sender {
    QRScanView *scan = [QRScanView new];
    scan.frame = self.view.bounds;
    __weak QRScanView *weakScan = scan;
    scan.didCloseViewCompletion = ^{
        [weakScan viewAnimation:ViewAnimationFadeOut animated:YES completion:^{
            [weakScan removeFromSuperview];
        }];
    };
    [self.view addSubview:scan];
    [scan viewAnimation:ViewAnimationFadeOut animated:NO];
    [scan viewAnimation:ViewAnimationFadeIn animated:YES];
}

- (IBAction)request_tui:(UIButton *)sender {
    RequestMessageView *requestMV = [RequestMessageView new];
    requestMV.name = @"Jon Snow";
    requestMV.age = 16;
    requestMV.distance = 1238000.f;
    [requestMV viewAnimation:ViewAnimationZoomIn animated:YES];
}

- (IBAction)found_tui:(UIButton *)sender {
    WaitingMessageView *waitingMV = [WaitingMessageView new];
    [waitingMV viewAnimation:ViewAnimationZoomIn animated:YES];
}

- (IBAction)setrating_tui:(UIButton *)sender {
    RatingMessageView *ratingMV = [RatingMessageView new];
    ratingMV.tokensCount = 32;
    __weak RatingMessageView *weakRatingMV = ratingMV;
    ratingMV.didCloseViewCompletion = ^{
        NSLog(@"Rating: %ld;", (unsigned long)weakRatingMV.rate);
    };
    [ratingMV viewAnimation:ViewAnimationZoomIn animated:YES];
}

- (IBAction)switch:(UISwitch *)sender {
    _testFuncView.hidden = !sender.on;
}

@end
