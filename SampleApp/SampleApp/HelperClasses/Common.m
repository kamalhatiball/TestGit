//
//  Common.m
//  GoNews24x7
//
//  Created by Developer iOS on 05/10/18.
//  Copyright © 2018 Developer IOS. All rights reserved.
//

#import "Common.h"

@implementation Common

#pragma mark - Shared Instance

static Common *helper = nil;

+ (id)sharedInstance {
    @synchronized(self) {
        if (!helper) {
            helper = [[Common alloc] init];
        }
    }
    return helper;
}

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)playButtonClickSound {
    /*NSString *effectTitle = @"Button click";
    SystemSoundID soundID;
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"aac"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);*/
}

- (void)moveToDashboard {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RootTabController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"RootTabController"];
    //rootViewController.selectedIndex = 2;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    UINavigationController *leftMenuNavigation = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuNavigation"];
    UITableViewController *rightViewController = [storyboard instantiateViewControllerWithIdentifier:@"RightMenuVC"];
    LGSideMenuController *sideMenuController = [LGSideMenuController sideMenuControllerWithRootViewController:navigationController
                                                                                           leftViewController:leftMenuNavigation
                                                                                          rightViewController:rightViewController];
    //sideMenuController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    sideMenuController.leftViewWidth = (SCREEN_WIDTH*3)/4;
    sideMenuController.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
    
    sideMenuController.rightViewWidth = 100.0;
    sideMenuController.rightViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
    
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:sideMenuController];
}

@end
