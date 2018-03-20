//
//  SMView.h
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "ScreenModeManager.h"


IB_DESIGNABLE

@interface SMView : UIView <ScreenModeProtocol>

@property (strong, nonatomic) IBInspectable UIColor *screenModeDayColor;
@property (strong, nonatomic) IBInspectable UIColor *screenModeNighColor;

@end
