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

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration;

- (void)deviceOrientationDidChange:(UIDeviceOrientation)deviceOrientation;

@end


IB_DESIGNABLE

@interface ViewController : UIViewController <ViewControllerProtocol>

@property (strong, nonatomic) NSString *imageNamed;

@property (assign, nonatomic) IBInspectable BOOL neededUpdateDeviceOrientation;

@end
