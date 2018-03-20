//
//  Macros.h
//
//
//  Created by Vladimir Psyukalov on 05.05.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#ifndef Macros_h
#define Macros_h

#define APPLICATION ([UIApplication sharedApplication])
#define DELEGATE ([[UIApplication sharedApplication] delegate])

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(VERSION) ([[[UIDevice currentDevice] systemVersion] compare:VERSION options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO_IOS_10 ([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending)

#define RGBA(R, G, B, A) ([UIColor colorWithRed:R / 255.f green:G / 255.f blue:B / 255.f alpha:A / 255.f])
#define RGB(R, G, B) ([UIColor colorWithRed:R / 255.f green:G / 255.f blue:B / 255.f alpha:1.f])

#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LOCALIZE(STRING) (NSLocalizedString(STRING, nil))

#define DEGREES_TO_RADIANS(DEGREES) (DEGREES * M_PI / 180.f)
#define RADIANS_TO_DEGREES(RADIANS) (RADIANS * 180.f / M_PI)

#endif /* Macros_h */
