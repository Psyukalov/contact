//
//  QRScanView.m
//  contact
//
//  Created by Vladimir Psyukalov on 26.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "QRScanView.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "ErrorMessageView.h"


@interface QRScanView () <AVCaptureMetadataOutputObjectsDelegate> {
    BOOL isDetected;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (strong, nonatomic) CAAnimationGroup *animationGroup;

@end


@implementation QRScanView

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _titleLabel.text = LOCALIZE(@"qrsv_label_0");
    _descriptionLabel.text = LOCALIZE(@"qrsv_label_1");
    [_okButton setTitle:LOCALIZE(@"qrsv_button_0") forState:UIControlStateNormal];
    for (UIView *view in @[_titleLabel, _descriptionLabel]) {
        [view shadowWithOffset:CGSizeZero color:[UIColor blackColor] opacity:1.f];
    }
    [_okButton shadowWithOffset:CGSizeZero color:[UIColor blackColor] opacity:.16f];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.contentView insertSubview:visualEffectView belowSubview:_titleLabel];
    [self.contentView addConstraintsWithView:visualEffectView customInsert:YES];
    [self performSelector:@selector(removeBlurView:) withObject:visualEffectView afterDelay:2.56f];
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    scaleAnimation.fromValue = @(1.f);
    scaleAnimation.toValue = @(1.032f);
    opacityAnimation.keyTimes = @[@(0.f), @(1.f)];
    opacityAnimation.values = @[@(1.f), @(.64f)];
    _animationGroup = [CAAnimationGroup animation];
    _animationGroup.animations = @[scaleAnimation, opacityAnimation];
    _animationGroup.duration = .64f;
    _animationGroup.autoreverses = YES;
    _animationGroup.repeatCount = INFINITY;
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self playAnimation];
    NSError *error;
    AVCaptureSession *captureSession = [AVCaptureSession new];
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error) {
        ErrorMessageView *errorMessageView = [ErrorMessageView new];
        errorMessageView.title = LOCALIZE(@"emv_label_0");
        errorMessageView.message = error.localizedDescription;
        errorMessageView.didCloseViewCompletion = ^{
            [self closeView];
        };
        [errorMessageView viewAnimation:ViewAnimationZoomIn animated:YES];
        return;
    }
    [captureSession addInput:captureDeviceInput];
    AVCaptureMetadataOutput *captureMetadataOutput = [AVCaptureMetadataOutput new];
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [captureSession addOutput:captureMetadataOutput];
    captureMetadataOutput.metadataObjectTypes = [captureMetadataOutput availableMetadataObjectTypes];
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    layer.frame = CGRectMake(0.f, 0.f, WIDTH, HEIGHT);
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.contentView.layer insertSublayer:layer atIndex:0];
    [captureSession startRunning];
}

#pragma mark - Other methods

- (void)closeView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self viewAnimation:ViewAnimationFadeOut animated:YES completion:^{
        if (self.didCloseViewCompletion) {
            self.didCloseViewCompletion();
        }
    }];
}

- (void)removeBlurView:(UIView *)blurView {
    [UIView animate:^{
        blurView.alpha = 0.f;
    } completion:^{
        [blurView removeFromSuperview];
    }];
}

- (void)playAnimation {
    [_scanImageView.layer addAnimation:_animationGroup forKey:nil];
}

- (void)stopAnimation {
    [_scanImageView.layer removeAllAnimations];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *string;
    for (AVMetadataObject *metadataObject in metadataObjects) {
        if (metadataObject.type == AVMetadataObjectTypeQRCode) {
            string = [(AVMetadataMachineReadableCodeObject *)metadataObject stringValue];
            break;
        }
    }
    if (string.length == 0 || isDetected) {
        return;
    }
    // TODO:
    [self stopAnimation];
    isDetected = YES;
    AudioServicesPlaySystemSound(1258);
    ErrorMessageView *errorMessageView = [ErrorMessageView new];
    errorMessageView.title = @"QR Scan";
    errorMessageView.message = [NSString stringWithFormat:@"Decoded string:\n%@\n(This popup just for test)", string];
    errorMessageView.didCloseViewCompletion = ^{
        [self playAnimation];
        isDetected = NO;
    };
    [errorMessageView viewAnimation:ViewAnimationZoomIn animated:YES];
}

#pragma mark - Actions

- (IBAction)closeButton_TUI:(UIButton *)sender {
    [self closeView];
}

- (IBAction)okButton_TUI:(UIButton *)sender {
    // TODO:
    [self closeView];
}

@end
