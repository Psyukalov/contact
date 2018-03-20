//
//  RegistrationView.h
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CView.h"


typedef NS_ENUM(NSUInteger, RegistrationAction) {
    RegistrationActionSignUp = 0
};


@protocol RegistrationViewDelegate <NSObject>

@optional

- (void)didSelectRegistrationAction:(RegistrationAction)registrationAction;

@end


@interface RegistrationView : CView

@property (weak, nonatomic) id<RegistrationViewDelegate> delegate;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *name;

@property (assign, nonatomic) NSUInteger age;

@property (assign, nonatomic) BOOL isFemale;
@property (assign, nonatomic) BOOL isPreferFemale;

@end
