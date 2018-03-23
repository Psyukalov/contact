//
//  EditProfileSlidingView.m
//  contact
//
//  Created by Vladimir Psyukalov on 23.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "EditProfileSlidingView.h"

#import "UITextField+Custom.h"

#import "ScreenModeManager.h"


@interface EditProfileSlidingView () <UITextFieldDelegate> {
    BOOL closed; // Fix bug "Fast opening profile view". "self.didCloseViewCompletion();" can run twice or more;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *maleLabel;
@property (weak, nonatomic) IBOutlet UILabel *preferMaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *femaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *preferFemaleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *genderSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *preferGenderSwitch;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end


@implementation EditProfileSlidingView

#pragma mark - Class properties

#pragma mark - Class methods

#pragma mark - Overriding properties

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    [self setIsOpen:YES animated:NO];
    [_confirmButton setTitle:LOCALIZE(@"epsv_button_0") forState:UIControlStateNormal];
    _descriptionLabel.text = LOCALIZE(@"epsv_label_0");
    _maleLabel.text = LOCALIZE(@"epsv_label_1");
    _preferMaleLabel.text = LOCALIZE(@"epsv_label_2");
    _femaleLabel.text = LOCALIZE(@"epsv_label_3");
    _preferFemaleLabel.text = LOCALIZE(@"epsv_label_4");
    _nameTextField.placeholder = LOCALIZE(@"epsv_placeholder_0");
    _ageTextField.placeholder = LOCALIZE(@"epsv_placeholder_1");
    [_nameTextField placeholderWithDefaultColor];
    [_ageTextField placeholderWithDefaultColor];
    for (UISwitch *genderSwitch in @[_genderSwitch, _preferGenderSwitch]) {
        genderSwitch.onTintColor = RGB(254.f, 168.f, 198.f);
        genderSwitch.backgroundColor = RGB(28.f, 132.f, 242.f);
        genderSwitch.tintColor = genderSwitch.backgroundColor;
        [genderSwitch cornerRadius:.5f * genderSwitch.frame.size.height];
    }
    [[ScreenModeManager shared] applyScreenMode]; // Need for attributed placeholders;
}

- (void)interfaceWithPercent:(CGFloat)percent {
    [super interfaceWithPercent:percent];
    if (!closed && percent == 0.f && self.didCloseViewCompletion) {
        closed = YES;
        self.didCloseViewCompletion();
        return;
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.isScrollEnabled = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.isScrollEnabled = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Other methods

#pragma mark - Actions

- (IBAction)confirmButton_TUI:(UIButton *)sender {
    [_nameTextField resignFirstResponder];
    [_ageTextField resignFirstResponder];
    [self setIsOpen:NO animated:YES];
}

@end
