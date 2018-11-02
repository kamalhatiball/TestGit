//
//  ARServiceHelperClass.h
//  NetworkingDemo
//
//  Created by Anshu on 07/03/17.
//  Copyright © 2017 Anshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import <AFNetworking.h>

#define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]

#define APPDELEGATE  (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define NSUSERDEFAULT  [NSUserDefaults standardUserDefaults]

#define SERVICE_URL  @"http://www.gonews247.com/wsgonewsmobile/InterfacesForAppDate.asmx/"

typedef enum {
    ARProgressNotShown = 0,
    ARProgressShown = 1
} ARProgressHud;

typedef void(^RequestComplitopnBlock)(id result, NSError  *error);

@interface LLCServiceHelperClass : NSObject {
    NSInteger responseCode;
    ARProgressHud progressHud;
}
+(id)shared;

- (void)postApiCallWithURL:(NSString *)urlString andWithParameters:(NSDictionary *)param withprogresHud:(ARProgressHud)hud WithComptionBlock:(RequestComplitopnBlock)block;

- (void)getApiCallWithURL:(NSString *)urlString andWithParameters:(NSDictionary *)param withprogresHud:(ARProgressHud)hud WithComptionBlock:(RequestComplitopnBlock)block;

- (void)directGetApiCallWithURL:(NSString *)urlString withprogresHud:(ARProgressHud)hud WithComptionBlock:(RequestComplitopnBlock)block;

- (void)specialAPICall:(NSString*)urlString parameters:(NSData*)paramData withprogresHud:(ARProgressHud)hud hudMessage:(NSString*)message WithComptionBlock:(RequestComplitopnBlock)block;

@end
