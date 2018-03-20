//
//  UILabel+Custom.h
//
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface UILabel (Custom)

- (void)attribute;
- (void)attributeWithAlignment:(NSTextAlignment)alignment;
- (void)attributeWithAlignment:(NSTextAlignment)alignment paragraphSpacing:(CGFloat)paragraphSpacing lineSpacing:(CGFloat)lineSpacing firstLineHeadIndent:(CGFloat)firstLineHeadIndent;

- (void)underline;
- (void)underlineWithRange:(NSRange)range;

@end
