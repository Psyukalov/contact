//
//  AboutContactView.m
//  contact
//
//  Created by Vladimir Psyukalov on 16.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "AboutContactView.h"

#import "UILabel+Custom.h"

#import "ScreenModeManager.h"


#define kImageViewRate (2.56f)
#define kTitleLabelRate (1.28f)
#define kDescriptionLabelRate (.64f)


@interface AboutContactView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end


@implementation AboutContactView

#pragma mark - Overriding properties

- (void)setParallaxPoint:(CGPoint)parallaxPoint {
    [super setParallaxPoint:parallaxPoint];
    CGFloat x = self.parallaxPoint.x;
    CGFloat y = self.parallaxPoint.y;
    [UIView animate:^{
        _imageView.transform = CGAffineTransformMakeTranslation(kImageViewRate * x, -kImageViewRate * y);
        _titleLabel.transform = CGAffineTransformMakeTranslation(kTitleLabelRate * x, -kTitleLabelRate * y);
        _descriptionLabel.transform = CGAffineTransformMakeTranslation(kDescriptionLabelRate * x, -kDescriptionLabelRate * y);
    } completion:nil duration:.16f];
}

#pragma mark - Overriding methods

- (void)loadViewFromNib {
    [super loadViewFromNib];
    _titleLabel.text = LOCALIZE(@"abcv_label_0");
    _descriptionLabel.text = LOCALIZE(@"abcv_label_1");
    [_descriptionLabel attribute];
}

- (IBAction)closeButton_TUI:(UIButton *)sender {
    if (self.didCloseViewCompletion) {
        self.didCloseViewCompletion();
    }
}

@end
