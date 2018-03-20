//
//  CObject.h
//  contact
//
//  Created by Vladimir Psyukalov on 06.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>


@protocol CObjectProtocol <NSObject>

@optional

+ (instancetype)shared;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)save;
- (void)load;

@end


@interface CObject : NSObject

@end
