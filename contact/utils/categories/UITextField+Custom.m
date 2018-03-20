//
//  UITextField+Custom.m
//
//
//  Created by Vladimir Psyukalov on 08.05.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "UITextField+Custom.h"


@implementation UITextField (Custom)

- (void)placeholderWithDefaultColor {
    [self placeholderWithColor:self.textColor];
}

- (void)placeholderWithColor:(UIColor *)color {
    NSDictionary *attributes = @{NSForegroundColorAttributeName : color, NSFontAttributeName : self.font};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
    self.attributedPlaceholder = attributedString;
}

@end
