//
//  ProfileSlidingView.h
//  contact
//
//  Created by Vladimir Psyukalov on 23.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "SlidingView.h"


typedef NS_ENUM(NSUInteger, ProfileAction) {
    ProfileActionShowHistory = 0,
    ProfileActionEditProfile,
    ProfileActionLogOut,
    ProfileActionAboutContact
};


@class ProfileSlidingView;


@protocol ProfileSlidingViewDelegate <NSObject>

@optional

- (void)profileView:(ProfileSlidingView *)profileView didSelectProfileAction:(ProfileAction)profileAction;

@end


@interface ProfileSlidingView : SlidingView

@property (assign, nonatomic) id<ProfileSlidingViewDelegate> delegate;

@end
