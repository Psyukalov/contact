//
//  Switch.m
//  contact
//
//  Created by Vladimir Psyukalov on 20.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "Switch.h"


@interface Switch ()

@property (strong, nonatomic) UIImageView *imageView;

@end


@implementation Switch

#pragma mark - Class properties

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = _image;
}

#pragma mark - Overriding methods

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageView = [UIImageView new];
    [self addSubview:_imageView];
    CGRect frame;
    frame.size.height = self.bounds.size.height;
    frame.size.width = frame.size.height;
    frame.origin.x = self.frame.size.width - frame.size.width + 3.2f;
    frame.origin.y = 0.f;
    _imageView.frame = frame;
    _imageView.contentMode = UIViewContentModeCenter;
    [self setImage:[UIImage imageNamed:@"mode_night_image"]];
}

@end
