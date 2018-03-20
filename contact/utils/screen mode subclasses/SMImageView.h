//
//  SMImageView.h
//  contact
//
//  Created by Vladimir Psyukalov on 16.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "ScreenModeManager.h"


IB_DESIGNABLE

@interface SMImageView : UIImageView <ScreenModeProtocol>

@property (strong, nonatomic) IBInspectable UIImage *screenModeDayImage;
@property (strong, nonatomic) IBInspectable UIImage *screenModeNighImage;

@end
