//
//  AuthorizationView.m
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "AuthorizationView.h"

#import "UITextField+Custom.h"


@interface AuthorizationView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *layer_0_View;
@property (weak, nonatomic) IBOutlet UIView *layer_1_View;
@property (weak, nonatomic) IBOutlet UIView *layer_2_View;

@property (weak, nonatomic) IBOutlet UIButton *login_0_Button;
@property (weak, nonatomic) IBOutlet UIButton *login_1_Button;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *vkontakteButton;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *copyrightLabel;

@property (weak, nonatomic) IBOutlet UIImageView *arrowIconImageView;

@end


@implementation AuthorizationView

#pragma mark - Override properties

- (CGRect)keyboardFrame {
    // TODO:
    return [super keyboardFrame];
}

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [_login_0_Button setTitle:LOCALIZE(@"av_button_0") forState:UIControlStateNormal];
    [_login_1_Button setTitle:LOCALIZE(@"av_button_1") forState:UIControlStateNormal];
    [_signUpButton setTitle:LOCALIZE(@"av_button_2") forState:UIControlStateNormal];
    [_forgotPasswordButton setTitle:LOCALIZE(@"av_button_3") forState:UIControlStateNormal];
    _descriptionLabel.text = LOCALIZE(@"av_label_0");
    NSString *format = LOCALIZE(@"av_label_1");
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"YYYY";
    NSString *yearString = [dateFormatter stringFromDate:[NSDate date]];
    _copyrightLabel.text = [NSString stringWithFormat:format, @"\u00A9", yearString];
    _arrowIconImageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180.f));
    _emailTextField.placeholder = LOCALIZE(@"av_placeholder_0");
    _passwordTextField.placeholder = LOCALIZE(@"av_placeholder_1");
    [_emailTextField placeholderWithDefaultColor];
    [_passwordTextField placeholderWithDefaultColor];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _emailTextField) {
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {
        [_passwordTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Other methods

- (void)selectAuthorizationAction:(AuthorizationAction)authorizationAction {
    [self endEditing:YES];
    if ([_delegate respondsToSelector:@selector(didSelectAuthorizationAction:)]) {
        [_delegate didSelectAuthorizationAction:authorizationAction];
    }
}

#pragma mark - Action methods

- (IBAction)login_0_Button_TUI:(UIButton *)sender {
    sender.selected = !sender.selected;
    BOOL selected = sender.selected;
    CGFloat y = ABS(_layer_0_View.frame.origin.y - _layer_2_View.frame.origin.y) + 40.f + _layer_0_View.frame.size.height;
    [UIView animate:^{
        _arrowIconImageView.transform = selected ? CGAffineTransformIdentity : CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180.f));
        _layer_0_View.transform = selected ? CGAffineTransformMakeTranslation(0.f, -y) : CGAffineTransformIdentity;
        _layer_1_View.alpha = selected ? 0.f : 1.f;
        _layer_2_View.alpha = selected ? 1.f : 0.f;
    }];
    if (!selected) {
        [self endEditing:YES];
    }
}

- (IBAction)login_1_Button_TUI:(UIButton *)sender {
    [self selectAuthorizationAction:AuthorizationActionLogin];
}

- (IBAction)facebookButton_TUI:(UIButton *)sender {
    [self selectAuthorizationAction:AuthorizationActionFacebook];
}

- (IBAction)vkontakteButton_TUI:(UIButton *)sender {
    [self selectAuthorizationAction:AuthorizationActionVKontakte];
}

- (IBAction)forgotPassword_TUI:(UIButton *)sender {
    [self selectAuthorizationAction:AuthorizationActionForgotPassword];
}

- (IBAction)signUpButton_TUI:(UIButton *)sender {
    [self selectAuthorizationAction:AuthorizationActionSignUp];
}

@end
