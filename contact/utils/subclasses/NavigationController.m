//
//  NavigationController.m
//
//
//  Created by Vladimir Psyukalov on 03.10.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "NavigationController.h"


@interface NavigationController ()

@end


@implementation NavigationController

#pragma mark - Overriding methods

- (BOOL)shouldAutorotate {
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

@end
