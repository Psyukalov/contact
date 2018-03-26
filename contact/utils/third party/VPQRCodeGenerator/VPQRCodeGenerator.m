//
//  VPQRCodeGenerator.m
//  contact
//
//  Created by Vladimir Psyukalov on 26.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "VPQRCodeGenerator.h"


@implementation VPQRCodeGenerator

#pragma mark - Overriding methods

- (instancetype)init {
    self = [super init];
    if (self) {
        _string = @"VPQRCodeGenerator";
        _size = 128.f;
        _size = VPQRCodeGeneratorQualityLow;
    }
    return self;
}

#pragma mark - Class methods

- (UIImage *)codeImage {
    NSData *data = [_string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSString *stringQuality;
    switch (_quality) {
        case VPQRCodeGeneratorQualityLow:
            stringQuality = @"L";
            break;
        case VPQRCodeGeneratorQualityMedium:
            stringQuality = @"M";
            break;
        case VPQRCodeGeneratorQualityNormal:
            stringQuality = @"Q";
            break;
        case VPQRCodeGeneratorQualityHigh:
            stringQuality = @"H";
            break;
    }
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:stringQuality forKey:@"inputCorrectionLevel"];
    CIImage *image = filter.outputImage;
    CGFloat size = _size / image.extent.size.width;
    CIImage *transformedImage = [image imageByApplyingTransform:CGAffineTransformMakeScale(size, size)];
    UIImage *resultImage = [UIImage imageWithCIImage:transformedImage];
    return resultImage;
}

@end
