//
//  VPQRCodeGenerator.h
//  contact
//
//  Created by Vladimir Psyukalov on 26.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, VPQRCodeGeneratorQuality) {
    VPQRCodeGeneratorQualityLow = 0,
    VPQRCodeGeneratorQualityMedium,
    VPQRCodeGeneratorQualityNormal,
    VPQRCodeGeneratorQualityHigh
};


@interface VPQRCodeGenerator : NSObject

@property (strong, nonatomic) NSString *string;

@property (assign, nonatomic) CGFloat size;

@property (assign, nonatomic) VPQRCodeGeneratorQuality quality;

- (UIImage *)codeImage;

@end
