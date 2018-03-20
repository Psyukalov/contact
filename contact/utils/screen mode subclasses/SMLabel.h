//
//  SMLabel.h
//  contact
//
//  Created by Vladimir Psyukalov on 16.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "ScreenModeManager.h"


IB_DESIGNABLE

@interface SMLabel : UILabel <ScreenModeProtocol>

@property (strong, nonatomic) IBInspectable UIColor *screenModeDayTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighTextColor;

@end
