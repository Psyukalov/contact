//
//  QRCodeView.m
//  contact
//
//  Created by Vladimir Psyukalov on 26.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "QRCodeView.h"

#import "VPQRCodeGenerator.h"


// TODO:

#define kDefaultString (@"Hello! It's Contact app for iOS!")

#define kSize (512.f)


@interface QRCodeView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;

@end


@implementation QRCodeView

#pragma mark - Class properties

#pragma mark - Class methods

#pragma mark - Overriding properties

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _titleLabel.text = LOCALIZE(@"qrcv_label_0");
    _descriptionLabel.text = LOCALIZE(@"qrcv_label_1");
    [_okButton setTitle:LOCALIZE(@"qrcv_button_0") forState:UIControlStateNormal];
    [self generateCodeWithString:kDefaultString];
}

#pragma mark - Other methods

- (void)closeView {
    [self viewAnimation:ViewAnimationFadeOut animated:YES completion:^{
        if (self.didCloseViewCompletion) {
            self.didCloseViewCompletion();
        }
    }];
}

- (void)generateCodeWithString:(NSString *)string {
    VPQRCodeGenerator *qrCodeGenerator = [VPQRCodeGenerator new];
    qrCodeGenerator.string = string;
    qrCodeGenerator.size = kSize;
    qrCodeGenerator.quality = VPQRCodeGeneratorQualityHigh;
    _codeImageView.image = [qrCodeGenerator codeImage];
}

#pragma mark - Actions

- (IBAction)closeButton_TUI:(UIButton *)sender {
    [self closeView];
}

- (IBAction)okButton_TUI:(UIButton *)sender {
    [self closeView];
}

@end
