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

@property (weak, nonatomic) IBOutlet SearchAnimationView *searchAnimationView;

@property (weak, nonatomic) IBOutlet AboutContactView *aboutContactView;

@property (weak, nonatomic) IBOutlet UISwitch *testSwitch;

@property (weak, nonatomic) IBOutlet UIView *maskedLeftView;
@property (weak, nonatomic) IBOutlet UIView *maskedRightView;

@property (weak, nonatomic) IBOutlet UISwitch *screenModeSwitch;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginProfileViewLC;

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
    [_aboutContactView viewAnimation:ViewAnimationFadeOut animated:NO];
    _aboutContactView.didCloseViewCompletion = ^{
        [self stopAccelerometerUpdates];
        [_aboutContactView viewAnimation:ViewAnimationFadeOut animated:YES];
    };
    _profileScrollView.decelerationRate = .84f;
    _profileScrollView.contentInset = UIEdgeInsetsMake(HEIGHT - _tokensView.frame.size.height - 18.f, 0.f, 0.f, 0.f);
    top = -(HEIGHT - _profileView.frame.size.height);
    bottom = -_profileScrollView.contentInset.top;
    [_maskedLeftView cornerRadius:4.f];
    [_maskedRightView cornerRadius:4.f];
    [self setIsOpen:NO animated:YES];
    _screenModeSwitch.on = [ScreenModeManager shared].isScreenModeNight;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // TODO:
    if (!value) {
        [self test];
        value = YES;
    }
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
    [_aboutContactView viewAnimation:ViewAnimationFadeIn animated:YES];
}

- (IBAction)screenModeSwitch_VC:(UISwitch *)sender {
    [[ScreenModeManager shared] toggleScreenMode];
}

#pragma mark -

- (void)testSwitchUnhide {
    [UIView animate:^{
        _testSwitch.alpha = 1.f;
    }];
}

- (void)test {
    AuthorizationViewController *authorizationVC = [AuthorizationViewController new];
    authorizationVC.view.frame = self.view.bounds;
    __weak AuthorizationViewController *weakAuthorizationVC = authorizationVC;
    authorizationVC.didCloseViewControllerCompletion = ^{
        [weakAuthorizationVC.view removeFromSuperview];
        [_searchAnimationView viewAnimation:ViewAnimationZoomIn animated:YES completion:^{
            [_searchAnimationView play];
            [self testSwitchUnhide];
        }];
    };
    [self.view addSubview:authorizationVC.view];
}

- (IBAction)test:(UISwitch *)sender {
    self.needed3DEffect = sender.on;
    _searchAnimationView.needed3DEffect = sender.on;
}

@end
