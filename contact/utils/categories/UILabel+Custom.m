//
//  UILabel+Custom.m
//
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "UILabel+Custom.h"


@implementation UILabel (Custom)

- (void)attribute {
    [self attributeWithAlignment:NSTextAlignmentLeft];
}

- (void)attributeWithAlignment:(NSTextAlignment)alignment {
    [self attributeWithAlignment:alignment paragraphSpacing:16.f lineSpacing:4.f firstLineHeadIndent:16.f];
}

- (void)attributeWithAlignment:(NSTextAlignment)alignment paragraphSpacing:(CGFloat)paragraphSpacing lineSpacing:(CGFloat)lineSpacing firstLineHeadIndent:(CGFloat)firstLineHeadIndent {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.paragraphSpacing = paragraphSpacing;
    paragraphStyle.alignment = alignment;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName : paragraphStyle,
                                 NSFontAttributeName : self.font,
                                 NSForegroundColorAttributeName : self.textColor};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
    self.attributedText = attributedString;
}

- (void)underline {
    [self underlineWithRange:NSMakeRange(0, self.text.length)];
}

- (void)underlineWithRange:(NSRange)range {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributeString addAttribute:NSUnderlineStyleAttributeName value:@(1.f) range:range];
    self.attributedText = attributeString;
}

@end
