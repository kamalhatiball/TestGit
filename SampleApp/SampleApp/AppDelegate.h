//
//  AppDelegate.h
//  SampleApp
//
//  Created by Developer iOS on 03/10/18.
//  Copyright © 2018 Developer IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property BOOL isReachable;
- (void)showToastControllerMessage:(NSString *)message;

@end

