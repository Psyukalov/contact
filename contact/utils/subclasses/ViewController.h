//
//  ViewController.h
//
//
//  Created by Vladimir Psyukalov on 07.12.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


@protocol ViewControllerProtocol <NSObject>

@optional

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration completion:(void (^)(void))completion;

- (void)deviceOrientationDidChange:(UIDeviceOrientation)deviceOrientation;

@end


@interface ViewController : UIViewController <ViewControllerProtocol>

@property (strong, nonatomic) NSString *imageNamed;

@end
