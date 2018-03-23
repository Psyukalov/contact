//
//  ProfileSlidingView.m
//  contact
//
//  Created by Vladimir Psyukalov on 23.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ProfileSlidingView.h"

#import "ScreenModeManager.h"


@interface ProfileSlidingView ()

@property (weak, nonatomic) IBOutlet UIView *tokensView;
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

@property (weak, nonatomic) IBOutlet UISwitch *invisibleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *notificationsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *nightModeSwitch;

@property (weak, nonatomic) IBOutlet UIButton *showHistoryButton;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutContactButton;

@end


@implementation ProfileSlidingView

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [self configureWithUnhideHeight:94.f / 812.f * HEIGHT];
    [self setIsOpen:NO animated:NO];
    _nightModeSwitch.on = [ScreenModeManager shared].isScreenModeNight;
    for (UISwitch *optionSwitch in @[_invisibleSwitch, _notificationsSwitch, _nightModeSwitch]) {
        optionSwitch.onTintColor = RGB(28.f, 132.f, 242.f);
        optionSwitch.backgroundColor = RGB(168.f, 168.f, 168.f);
        optionSwitch.tintColor = optionSwitch.backgroundColor;
        [optionSwitch cornerRadius:.5f * optionSwitch.frame.size.height];
    }
    _nightModeSwitch.backgroundColor = RGB(52.f, 54.f, 102.f);
    _nightModeSwitch.tintColor = _nightModeSwitch.backgroundColor;
    [_showHistoryButton setTitle:LOCALIZE(@"psv_button_0") forState:UIControlStateNormal];
    [_editProfileButton setTitle:LOCALIZE(@"psv_button_1") forState:UIControlStateNormal];
    [_logOutButton setTitle:LOCALIZE(@"psv_button_2") forState:UIControlStateNormal];
    [_aboutContactButton setTitle:LOCALIZE(@"psv_button_3") forState:UIControlStateNormal];
    _invisibleLabel.text = LOCALIZE(@"psv_label_0");
    _notificationsLabel.text = LOCALIZE(@"psv_label_1");
    _nightModeLabel.text = LOCALIZE(@"psv_label_2");
}

- (void)interfaceWithPercent:(CGFloat)percent {
    [super interfaceWithPercent:percent];
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
}

#pragma mark - Other methods

- (void)selectProfileAction:(ProfileAction)profileAction {
    if ([_delegate respondsToSelector:@selector(profileView:didSelectProfileAction:)]) {
        [_delegate profileView:self didSelectProfileAction:profileAction];
    }
}

#pragma mark - Actions

- (IBAction)showHistoryButton_TUI:(UIButton *)sender {
    [self selectProfileAction:ProfileActionShowHistory];
}

- (IBAction)editProfileButton_TUI:(UIButton *)sender {
    [self selectProfileAction:ProfileActionEditProfile];
}

- (IBAction)logOutButton_TUI:(UIButton *)sender {
    [self selectProfileAction:ProfileActionLogOut];
}

- (IBAction)aboutContactButton_TUI:(UIButton *)sender {
    [self selectProfileAction:ProfileActionAboutContact];
}

- (IBAction)invisibleSwitch_VC:(UISwitch *)sender {
    // TODO:
}

- (IBAction)notificationsSwitch_VC:(UISwitch *)sender {
    // TODO:
}

- (IBAction)nightModeSwitch_VC:(UISwitch *)sender {
    [[ScreenModeManager shared] toggleScreenMode];
}

@end
