//
//  RegistrationView.m
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "RegistrationView.h"

#import "UITextField+Custom.h"


@interface RegistrationView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *signUp_0_Button;
@property (weak, nonatomic) IBOutlet UIButton *signUp_1_Button;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@property (weak, nonatomic) IBOutlet UISwitch *genderSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *preferGenderSwitch;

@property (weak, nonatomic) IBOutlet UILabel *maleLabel;
@property (weak, nonatomic) IBOutlet UILabel *preferMaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *femaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *preferFemaleLabel;

@end


@implementation RegistrationView

#pragma mark - Class properties

- (NSString *)email {
    return _emailTextField.text;
}

- (NSString *)name {
    return _nameTextField.text;
}

- (NSUInteger)age {
    return  [_ageTextField.text integerValue];
}

- (BOOL)isFemale {
    return _genderSwitch.on;
}

- (BOOL)isPreferFemale {
    return _preferGenderSwitch.on;
}

#pragma mark - Override properties

- (CGRect)keyboardFrame {
    // TODO:
    return [super keyboardFrame];
}

#pragma mark - Override methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [_signUp_0_Button setTitle:LOCALIZE(@"rv_button_0") forState:UIControlStateNormal];
    [_signUp_1_Button setTitle:LOCALIZE(@"rv_button_1") forState:UIControlStateNormal];
    _emailTextField.placeholder = LOCALIZE(@"rv_placeholder_0");
    _nameTextField.placeholder = LOCALIZE(@"rv_placeholder_1");
    _ageTextField.placeholder = LOCALIZE(@"rv_placeholder_2");
    _maleLabel.text = LOCALIZE(@"rv_label_0");
    _preferMaleLabel.text = LOCALIZE(@"rv_label_1");
    _femaleLabel.text = LOCALIZE(@"rv_label_2");
    _preferFemaleLabel.text = LOCALIZE(@"rv_label_3");
    [_emailTextField placeholderWithDefaultColor];
    [_nameTextField placeholderWithDefaultColor];
    [_ageTextField placeholderWithDefaultColor];
    for (UISwitch *genderSwitch in @[_genderSwitch, _preferGenderSwitch]) {
        genderSwitch.onTintColor = RGB(254.f, 168.f, 198.f);
        genderSwitch.backgroundColor = RGB(28.f, 132.f, 242.f);
        genderSwitch.tintColor = genderSwitch.backgroundColor;
        [genderSwitch cornerRadius:.5f * genderSwitch.frame.size.height];
    }
    UISwipeGestureRecognizer *downSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlerDownSwipeGR)];
    downSwipeGR.direction = UISwipeGestureRecognizerDirectionDown;
    [self.contentView addGestureRecognizer:downSwipeGR];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _emailTextField) {
        [_nameTextField becomeFirstResponder];
    } else if (textField == _nameTextField) {
        [_ageTextField becomeFirstResponder];
    } else {
        [_ageTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Other methods

- (void)selectRegistrationAction:(RegistrationAction)registrationAction {
    [self endEditing:YES];
    if ([_delegate respondsToSelector:@selector(didSelectRegistrationAction:)]) {
        [_delegate didSelectRegistrationAction:registrationAction];
    }
}

#pragma mark - Actions

- (IBAction)signUp_1_Button_TUI:(UIButton *)sender {
    [self selectRegistrationAction:RegistrationActionSignUp];
}

- (IBAction)signUp_0_Button_TUI:(UIButton *)sender {
    [self endEditing:YES];
    if (self.didCloseViewCompletion) {
        self.didCloseViewCompletion();
    }
}

- (void)handlerDownSwipeGR {
    [self signUp_0_Button_TUI:_signUp_0_Button];
}

@end
