//
//  AppDelegate.m
//  SampleApp
//
//  Created by Developer iOS on 03/10/18.
//  Copyright © 2018 Developer IOS. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate> {
    
    Reachability *internetReachable;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /* FBSDK Application SetUp */
    /*[[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fbAccessTokenDidChange:)
                                                 name:FBSDKAccessTokenDidChangeNotification
                                               object:nil];*/
    
    /* For Net Reachability */
    internetReachable = [Reachability reachabilityWithHostName:SERVICE_URL];
    self.isReachable = internetReachable.isReachable;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNetworkChange:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [internetReachable startNotifier];
    //[self registerForRemoteNotifications];
    return YES;
}

#pragma mark - Notifications

/*
- (void)registerForRemoteNotifications {
    UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert|UIUserNotificationTypeBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
        }];
        
    }else {
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
            
            [[UIApplication sharedApplication] registerUserNotificationSettings: [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:nil]];
        }
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    //[UserInfo shared].deviceToken = token;
    NSLog(@"My device token is: %@", token);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)){
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center  didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    completionHandler();
}*/

- (void)handleNetworkChange:(NSNotification *)notice {
    
    NetworkStatus status = [[Reachability reachabilityWithHostName:SERVICE_URL] currentReachabilityStatus];
    
    switch (status) {
        case NotReachable: {
            self.isReachable = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReachabilityOff" object:self];
            break;
        }
        case ReachableViaWiFi: {
            self.isReachable = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReachabilityOn" object:self];
            break;
        }
        case ReachableViaWWAN: {
            self.isReachable = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReachabilityOn" object:self];
            break;
        }
            
    }
}

#pragma mark - Show Toast Alert Method

- (void)showToastControllerMessage:(NSString *)message {
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageColor = [UIColor whiteColor];
    style.backgroundColor = [UIColor blackColor];
    [appDelegate.window makeToast:message
                         duration:1.5
                         position:CSToastPositionBottom
                            style:style];
    [CSToastManager setSharedStyle:style];
    [CSToastManager setTapToDismissEnabled:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/*
#pragma mark - Facebook Login Implementation

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
        return YES;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    
    NSString *sourceApplication = options[UIApplicationOpenURLOptionsSourceApplicationKey];
    
    if([[FBSDKApplicationDelegate sharedInstance] application:app openURL:url sourceApplication:sourceApplication annotation:sourceApplication]){
        return YES;
    }
    return NO;
}

- (void)fbAccessTokenDidChange:(NSNotification*)notification {
    
    if ([notification.name isEqualToString:FBSDKAccessTokenDidChangeNotification]) {
        
        FBSDKAccessToken* oldToken = [notification.userInfo valueForKey: FBSDKAccessTokenChangeOldKey];
        FBSDKAccessToken* newToken = [notification.userInfo valueForKey: FBSDKAccessTokenChangeNewKey];
        
        if (newToken != nil && oldToken == nil) {
            
            NSDate *nowDate = [NSDate date];
            NSDate *fbExpirationDate = [FBSDKAccessToken currentAccessToken].expirationDate;
            
            if ([fbExpirationDate compare:nowDate] != NSOrderedDescending) {
                NSLog(@"FB token: expired");
                [self logoutFacebook];
            } else {
                [self syncFacebookAccessTokenWithServer];
            }
            
        } else if (newToken != nil && oldToken != nil && ![oldToken.tokenString isEqualToString:newToken.tokenString]) {
            
            NSLog(@"FB access token string did change");
            [self syncFacebookAccessTokenWithServer];
            
        } else if (newToken == nil && oldToken != nil) {
            
            NSLog(@"FB access token string did become nil");
            
        }
        
        [self getFBResult];
    }
}

- (void)logoutFacebook {
    if ([FBSDKAccessToken currentAccessToken]) {
        [[FBSDKLoginManager new] logOut];
    }
}

- (void)syncFacebookAccessTokenWithServer {
    if (![FBSDKAccessToken currentAccessToken]) {
        // returns if empty token
        return;
    }
}

- (void)getFBResult {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name,  first_name, picture.type(large), email, gender"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             
             if (!error) {
                 if ([result valueForKey:@"id"]) {
                     NSString *emailID = [[result valueForKey:@"email"] stringByReplacingOccurrencesOfString:@" " withString:@""];
                     NSString *fbId = [[result valueForKey:@"id"] stringByReplacingOccurrencesOfString:@" " withString:@""];
                     
                     [[UserInfo shared] setUserEmailId:emailID];
                     [[UserInfo shared] setUserFBId:fbId];
                     
                     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                     ProfileVC *mainview = [storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
                     mainview.dataDict = result;
                     [self->_window.rootViewController.navigationController pushViewController:mainview animated:YES];
                 }
             }
             else {
                 NSLog(@"error : %@",error);
             }
         }];
    }
}
*/

@end
