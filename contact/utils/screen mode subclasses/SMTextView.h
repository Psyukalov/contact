//
//  SMTextView.h
//  contact
//
//  Created by Vladimir Psyukalov on 29.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MBAutoGrowingTextView.h"

#import "ScreenModeManager.h"


IB_DESIGNABLE

@interface SMTextView : MBAutoGrowingTextView <ScreenModeProtocol>

@property (strong, nonatomic) IBInspectable UIColor *screenModeDayTextColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighTextColor;

@end
