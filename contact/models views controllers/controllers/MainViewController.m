//
//  MainViewController.m
//  contact
//
//  Created by Vladimir Psyukalov on 19.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MainViewController.h"

#import "SearchAnimationView.h"
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
@property (weak, nonatomic) IBOutlet UIButton *aboutContactButton;

@property (weak, nonatomic) IBOutlet UISwitch *invisibleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *notificationsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *screenModeSwitch;

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

- (void)setIsOpen:(BOOL)isOpen animated:(BOOL)animated {
    _isOpen = isOpen;
    [_profileScrollView setContentOffset:CGPointMake(0.f, _isOpen ? top : bottom) animated:animated];
}

#pragma mark - Overriding methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    [_searchAnimationView viewAnimation:ViewAnimationZoomOut animated:NO];
    _profileScrollView.contentInset = UIEdgeInsetsMake(HEIGHT - _tokensView.frame.size.height - 18.f, 0.f, 0.f, 0.f);
    top = -(HEIGHT - _profileView.frame.size.height);
    bottom = -_profileScrollView.contentInset.top;
    [_maskedLeftView cornerRadius:4.f];
    [_maskedRightView cornerRadius:4.f];
    [self setIsOpen:NO animated:YES];
    _screenModeSwitch.on = [ScreenModeManager shared].isScreenModeNight;
    for (UISwitch *optionSwitch in @[_invisibleSwitch, _notificationsSwitch, _screenModeSwitch]) {
        optionSwitch.onTintColor = RGB(28.f, 132.f, 242.f);
        optionSwitch.backgroundColor = RGB(168.f, 168.f, 168.f);
        optionSwitch.tintColor = optionSwitch.backgroundColor;
        [optionSwitch cornerRadius:.5f * optionSwitch.frame.size.height];
    }
    _screenModeSwitch.backgroundColor = RGB(52.f, 54.f, 102.f);
    _screenModeSwitch.tintColor = _screenModeSwitch.backgroundColor;
    [_showHistoryButton setTitle:LOCALIZE(@"mvc_button_0") forState:UIControlStateNormal];
    [_editProfileButton setTitle:LOCALIZE(@"mvc_button_1") forState:UIControlStateNormal];
    [_aboutContactButton setTitle:LOCALIZE(@"mvc_button_2") forState:UIControlStateNormal];
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
        _tokensView.alpha = 1.f - percent;
        _tokens_1_Label.alpha = percent;
        _logotype_1_ImageView.alpha = percent;
        _showHistoryButton.alpha = percent;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (scrollView == _profileScrollView && !decelerate) {
        [self changeInterfaceWithScrollView:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _profileScrollView) {
        [self changeInterfaceWithScrollView:scrollView];
    }
}

#pragma mark - Other methods

- (void)changeInterfaceWithScrollView:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    CGFloat switchBorder = _isOpen ? top - _deltaSwitchBorder : bottom + _deltaSwitchBorder;
    [self setIsOpen:y >= switchBorder animated:YES];
}

#pragma mark - Actions

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

- (IBAction)screenModeSwitch_VC:(UISwitch *)sender {
    [[ScreenModeManager shared] toggleScreenMode];
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
        }];
    };
    [self.view addSubview:authorizationVC.view];
}

@end
