//
//  MainViewController.m
//  contact
//
//  Created by Vladimir Psyukalov on 19.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MainViewController.h"

#import "SearchAnimationView.h"
#import "HistoryView.h"
#import "AboutContactView.h"

#import "AuthorizationViewController.h"

#import "ScreenModeManager.h"


@interface MainViewController () {
    CGFloat top;
    CGFloat bottom;
    BOOL value;
}

@property (weak, nonatomic) IBOutlet UIScrollView *profileScrollView;

@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIView *contentProfileView;
@property (weak, nonatomic) IBOutlet UIView *tokensView;
@property (weak, nonatomic) IBOutlet UIView *maskedLeftView;
@property (weak, nonatomic) IBOutlet UIView *maskedRightView;
@property (weak, nonatomic) IBOutlet UIView *divide_0_View;
@property (weak, nonatomic) IBOutlet UIView *divide_1_View;

@property (weak, nonatomic) IBOutlet UILabel *tokens_0_Label;
@property (weak, nonatomic) IBOutlet UILabel *tokens_1_Label;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *invisibleLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightModeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *logotype_0_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logotype_1_ImageView;

@property (weak, nonatomic) IBOutlet UIButton *showHistoryButton;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutContactButton;

@property (weak, nonatomic) IBOutlet UISwitch *invisibleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *notificationsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *nightModeSwitch;

@property (weak, nonatomic) IBOutlet SearchAnimationView *searchAnimationView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginProfileViewLC;

@property (strong, nonatomic) CView *customView;

@property (assign, nonatomic) BOOL isOpen;

@end


@implementation MainViewController

#pragma mark - Class properties

- (void)setIsOpen:(BOOL)isOpen {
    [self setIsOpen:isOpen animated:YES];
}

#pragma mark - Class methods

- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated {
    [self interfaceHidden:hidden animated:animated completion:nil];
}

- (void)interfaceHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(void))completion {
    CGAffineTransform transform = hidden ? CGAffineTransformMakeTranslation(0.f, _tokensView.frame.size.height + 18.f) : CGAffineTransformIdentity;
    if (animated) {
        if (!hidden) {
            _profileScrollView.hidden = NO;
        }
        [UIView animate:^{
            _profileScrollView.transform = transform;
        } completion:^{
            if (hidden) {
                _profileScrollView.hidden = YES;
            }
            if (completion) {
                completion();
            }
        } duration:.64f];
    } else {
        _profileScrollView.transform = transform;
        _profileScrollView.hidden = hidden;
        if (completion) {
            completion();
        }
    }
}

#pragma mark - Overriding methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    [self interfaceHidden:YES animated:NO];
    [_searchAnimationView viewAnimation:ViewAnimationZoomOut animated:NO];
    _profileScrollView.decelerationRate = .16f;
    _profileScrollView.contentInset = UIEdgeInsetsMake(HEIGHT - _tokensView.frame.size.height - 18.f, 0.f, 0.f, 0.f);
    top = -(HEIGHT - _profileView.frame.size.height);
    bottom = -_profileScrollView.contentInset.top;
    [_maskedLeftView cornerRadius:4.f];
    [_maskedRightView cornerRadius:4.f];
    [self setIsOpen:NO animated:YES];
    _nightModeSwitch.on = [ScreenModeManager shared].isScreenModeNight;
    for (UISwitch *optionSwitch in @[_invisibleSwitch, _notificationsSwitch, _nightModeSwitch]) {
        optionSwitch.onTintColor = RGB(28.f, 132.f, 242.f);
        optionSwitch.backgroundColor = RGB(168.f, 168.f, 168.f);
        optionSwitch.tintColor = optionSwitch.backgroundColor;
        [optionSwitch cornerRadius:.5f * optionSwitch.frame.size.height];
    }
    _nightModeSwitch.backgroundColor = RGB(52.f, 54.f, 102.f);
    _nightModeSwitch.tintColor = _nightModeSwitch.backgroundColor;
    [_showHistoryButton setTitle:LOCALIZE(@"mvc_button_0") forState:UIControlStateNormal];
    [_editProfileButton setTitle:LOCALIZE(@"mvc_button_1") forState:UIControlStateNormal];
    [_logOutButton setTitle:LOCALIZE(@"mvc_button_2") forState:UIControlStateNormal];
    [_aboutContactButton setTitle:LOCALIZE(@"mvc_button_3") forState:UIControlStateNormal];
    _invisibleLabel.text = LOCALIZE(@"mvc_label_0");
    _notificationsLabel.text = LOCALIZE(@"mvc_label_1");
    _nightModeLabel.text = LOCALIZE(@"mvc_label_2");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // TODO:
    if (!value) {
        [self test];
        value = YES;
    }
}

- (void)accelerometerUpdateWithAcceleration:(CMAcceleration)acceleration {
    [super accelerometerUpdateWithAcceleration:acceleration];
    _customView.parallaxPoint = CGPointMake(acceleration.x, acceleration.y);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _profileScrollView) {
        CGFloat y = scrollView.contentOffset.y;
        CGFloat percent = (ABS(bottom) - ABS(y)) / (ABS(bottom) - ABS(top));
        CGFloat margin = _leftMarginProfileViewLC.constant;
        _maskedLeftView.transform = CGAffineTransformMakeTranslation(percent * -margin, 0.f);
        _maskedRightView.transform = CGAffineTransformMakeTranslation(percent * margin, 0.f);
        BOOL condition = percent == 0.f || percent == 1.f;
        NSUInteger i = 0;
        for (UIView *view in @[_tokens_1_Label, _logotype_1_ImageView, _showHistoryButton, _divide_0_View, _nameLabel, _editProfileButton, _logOutButton, _divide_1_View, _invisibleLabel, _invisibleSwitch, _notificationsLabel, _notificationsSwitch, _nightModeLabel, _nightModeSwitch, _aboutContactButton]) {
            if (condition) {
                CGFloat rate = [view isKindOfClass:[UISwitch class]] ? -1.f : 1.f;
                [UIView animateWithDuration:.32f delay:i * .08f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    view.alpha = percent;
                    view.transform = CGAffineTransformMakeTranslation((1.f - percent) * rate * 8.f, 0.f);
                } completion:nil];
            } else {
                view.alpha = 0.f;
            }
            i++;
        }
        if (condition) {
            [UIView animate:^{
                _tokensView.alpha = 1.f - percent;
            } completion:nil duration:.32f];
        } else {
            _tokensView.alpha = 0.f;
        }
        if (scrollView.decelerating) {
            [self changeInterfaceWithScrollView:scrollView];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (scrollView == _profileScrollView && !decelerate) {
        [self changeInterfaceWithScrollView:scrollView];
    }
}

#pragma mark - Other methods

- (void)changeInterfaceWithScrollView:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    CGFloat switchBorder = _isOpen ? top - _deltaSwitchBorder : bottom + _deltaSwitchBorder;
    [self setIsOpen:y >= switchBorder animated:YES];
}

- (void)setIsOpen:(BOOL)isOpen animated:(BOOL)animated {
    [self setIsOpen:isOpen animated:animated completion:nil];
}

- (void)setIsOpen:(BOOL)isOpen animated:(BOOL)animated completion:(void (^)(void))completion {
    _isOpen = isOpen;
    [UIView animateWithDuration:.44f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _profileScrollView.contentOffset = CGPointMake(0.f, _isOpen ? top : bottom);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - Actions

- (IBAction)showHistoryButton_TUI:(UIButton *)sender {
    HistoryView *historyView = [[HistoryView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:historyView];
    [historyView viewDirection:ViewDirectionBottom animated:NO];
    __weak MainViewController *weakSelf = self;
    [self setIsOpen:NO animated:YES completion:^{
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
                        [self setIsOpen:YES];
                    }];
                }];
            }];
        }];
    };
}

- (IBAction)logOutButton_TUI:(UIButton *)sender {
    // TODO:
    __weak MainViewController *weakSelf = self;
    [self setIsOpen:NO animated:YES completion:^{
        [weakSelf interfaceHidden:YES animated:YES completion:^{
            [weakSelf.searchAnimationView viewAnimation:ViewAnimationZoomOut animated:YES completion:^{
                [weakSelf.searchAnimationView stop];
                [weakSelf test];
            }];
        }];
    }];
}

- (IBAction)nightModeSwitch_VC:(UISwitch *)sender {
    [[ScreenModeManager shared] toggleScreenMode];
}

- (IBAction)aboutContactButton_TUI:(UIButton *)sender {
    [self startAccelerometerUpdates];
    [_searchAnimationView stop];
    AboutContactView *aboutContactView = [[AboutContactView alloc] initWithFrame:self.view.bounds];
    _customView = aboutContactView;
    [self.view addSubview:aboutContactView];
    [aboutContactView viewAnimation:ViewAnimationFadeOut animated:NO];
    [aboutContactView viewAnimation:ViewAnimationFadeIn animated:YES];
    __weak AboutContactView *weakAboutContactView = aboutContactView;
    aboutContactView.didCloseViewCompletion = ^{
        [self stopAccelerometerUpdates];
        [_searchAnimationView play];
        _customView = nil;
        [weakAboutContactView viewAnimation:ViewAnimationFadeOut animated:YES completion:^{
            [weakAboutContactView removeFromSuperview];
        }];
    };
}

#pragma mark - Test

- (void)test {
    [_searchAnimationView stop];
    AuthorizationViewController *authorizationVC = [AuthorizationViewController new];
    authorizationVC.view.frame = self.view.bounds;
    __weak AuthorizationViewController *weakAuthorizationVC = authorizationVC;
    authorizationVC.didCloseViewControllerCompletion = ^{
        [weakAuthorizationVC.view removeFromSuperview];
        [_searchAnimationView viewAnimation:ViewAnimationZoomIn animated:YES completion:^{
            [_searchAnimationView play];
            [self interfaceHidden:NO animated:YES];
        }];
    };
    [self.view addSubview:authorizationVC.view];
}

@end
