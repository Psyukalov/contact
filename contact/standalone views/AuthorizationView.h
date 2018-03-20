//
//  AuthorizationView.h
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CView.h"


typedef NS_ENUM(NSUInteger, AuthorizationAction) {
    AuthorizationActionLogin = 0,
    AuthorizationActionFacebook,
    AuthorizationActionVKontakte,
    AuthorizationActionForgotPassword,
    AuthorizationActionSignUp
};


@protocol AuthorizationViewDelegate <NSObject>

@optional

- (void)didSelectAuthorizationAction:(AuthorizationAction)authorizationAction;

@end


@interface AuthorizationView : CView

@property (assign, nonatomic) id<AuthorizationViewDelegate> delegate;

@end
