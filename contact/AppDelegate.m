//
//  AppDelegate.m
//  contact
//
//  Created by Vladimir Psyukalov on 14.03.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "AppDelegate.h"

#import "MainViewController.h"


@interface AppDelegate ()

@end


@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setup];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //
}

#pragma mark - Other methods

- (void)setup {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = RGB(28.f, 4.f, 72.f);
    self.window.rootViewController = [MainViewController new];
    [self.window makeKeyAndVisible];
}

@end
