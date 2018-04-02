//
//  SMTextField.h
//  contact
//
//  Created by Vladimir Psyukalov on 23.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "ScreenModeManager.h"


IB_DESIGNABLE

@interface SMTextField : UITextField <ScreenModeProtocol>

@property (strong, nonatomic) IBInspectable UIColor *screenModeDayTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighTextColor;

@property (strong, nonatomic) IBInspectable UIColor *screenModeDayPlaceholderColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighPlaceholderColor;

@end
