//
//  ARServiceHelperClass.m
//  NetworkingDemo
//
//  Created by Anshu on 07/03/17.
//  Copyright © 2017 Anshu. All rights reserved.
//

#import "LLCServiceHelperClass.h"


@interface LLCServiceHelperClass () {
    MBProgressHUD *progressHUD;
}
@end

@implementation LLCServiceHelperClass
RequestComplitopnBlock  responseBlock;
static LLCServiceHelperClass *helper = nil;

#pragma mark - Shared Instance

+ (id)shared {
    @synchronized(self) {
        if (!helper) {
            helper = [[LLCServiceHelperClass alloc] init];
        }
    }
    return helper;
}

#pragma mark - Post Request Method

- (void)postApiCallWithURL:(NSString *)urlString andWithParameters:(NSDictionary *)param withprogresHud:(ARProgressHud)hud WithComptionBlock:(RequestComplitopnBlock)block {
    responseBlock = [block copy];
    
    if(![APPDELEGATE isReachable]) {
        [[APPDELEGATE window] setUserInteractionEnabled:YES];
        NSError *error = [[NSError alloc] initWithDomain:@"" code:101 userInfo:nil];
    [MBProgressHUD hideHUDForView:[APPDELEGATE window] animated:YES];

        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Connection Error!" message:@"Unable to connect network, Please check your internet connection." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [ROOTVIEW presentViewController:alert animated:YES completion:nil];
        responseBlock(nil,error);
        return;
    }
    [self setProgressHud:hud];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVICE_URL, urlString];
    NSURL *URL = [NSURL URLWithString:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json",@"text/html"]];
    
    [manager POST:URL.absoluteString parameters:param  progress:nil success:^(NSURLSessionTask *task, id responseObject){
        
        NSLog(@"Response%@",responseObject);
        // . . . when request succeeds
        
        [self hideProgressHud];
        self->progressHUD = nil;
        responseBlock(responseObject,nil);
        
        
    }failure:^(NSURLSessionTask *myOperation, NSError *error){
        // . . . if something goes wrong
        [self hideProgressHud];
        self->progressHUD = nil;
        responseBlock(nil,error);
    }];
}

#pragma mark - Get Request Method

- (void)getApiCallWithURL:(NSString *)urlString andWithParameters:(NSDictionary *)param withprogresHud:(ARProgressHud)hud WithComptionBlock:(RequestComplitopnBlock)block {
    responseBlock = [block copy];
    [self setProgressHud:hud];
    if(![APPDELEGATE isReachable]) {
        [[APPDELEGATE window] setUserInteractionEnabled:YES];
        NSError *error = [[NSError alloc] initWithDomain:@"" code:101 userInfo:nil];
    [MBProgressHUD hideHUDForView:[APPDELEGATE window] animated:YES];

        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Connection Error!" message:@"Unable to connect network, Please check your internet connection." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [ROOTVIEW presentViewController:alert animated:YES completion:nil];
        responseBlock(nil,error);
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVICE_URL, urlString];

    NSURL *URL = [NSURL URLWithString:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json",@"text/html"]];
    
    [manager GET:URL.absoluteString parameters:param  progress:nil success:^(NSURLSessionTask *task, id responseObject){
        
        NSLog(@"Response%@",responseObject);
        // . . . when request succeeds
        [self hideProgressHud];
        
        self->progressHUD = nil;
        responseBlock(responseObject,nil);
        
        
    }failure:^(NSURLSessionTask *myOperation, NSError *error){
        
        // . . . if something goes wrong
        [self hideProgressHud];
        
        self->progressHUD = nil;
        responseBlock(nil,error);
    }];
}

- (void)directGetApiCallWithURL:(NSString *)urlString withprogresHud:(ARProgressHud)hud WithComptionBlock:(RequestComplitopnBlock)block {
    responseBlock = [block copy];
    [self setProgressHud:hud];
    if(![APPDELEGATE isReachable]) {
        [[APPDELEGATE window] setUserInteractionEnabled:YES];
        NSError *error = [[NSError alloc] initWithDomain:@"" code:101 userInfo:nil];
        [MBProgressHUD hideHUDForView:[APPDELEGATE window] animated:YES];
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Connection Error!" message:@"Unable to connect network, Please check your internet connection." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [ROOTVIEW presentViewController:alert animated:YES completion:nil];
        responseBlock(nil,error);
        return;
   }
    NSString *url = [NSString stringWithFormat:@"%@",urlString];
    NSURL *URL = [NSURL URLWithString:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json",@"text/html",@"text/plain"]];
    
    [manager GET:URL.absoluteString parameters:nil  progress:nil success:^(NSURLSessionTask *task, id responseObject){
        
        NSLog(@"Response%@",responseObject);
        // . . . when request succeeds
        [self hideProgressHud];
        self->progressHUD = nil;
        responseBlock(responseObject,nil);
        
    }failure:^(NSURLSessionTask *myOperation, NSError *error){
        
        // . . . if something goes wrong
        
        [self hideProgressHud];
        self->progressHUD = nil;
        responseBlock(nil,error);
    }];
}

- (void)specialAPICall:(NSString*)urlString parameters:(NSData*)paramData withprogresHud:(ARProgressHud)hud hudMessage:(NSString*)message WithComptionBlock:(RequestComplitopnBlock)block {
    
    responseBlock = [block copy];
    [self setProgressHud:hud];

    if(![APPDELEGATE isReachable]) {
        [[APPDELEGATE window] setUserInteractionEnabled:YES];
        NSError *error = [[NSError alloc] initWithDomain:@"" code:101 userInfo:nil];
        [MBProgressHUD hideHUDForView:[APPDELEGATE window] animated:YES];

        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Connection Error!" message:@"Unable to connect network, Please check your internet connection." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [ROOTVIEW presentViewController:alert animated:YES completion:nil];
        responseBlock(nil,error);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:15.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[paramData length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:paramData];
    
    NSError *requestError;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response error:&requestError];
    NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    [MBProgressHUD hideHUDForView:[APPDELEGATE window] animated:YES];
    progressHUD = nil;
    responseBlock(@{@"msg":responseString}, nil);
}

#pragma mark - Hud Method

- (void)setProgressHud:(ARProgressHud)hud {
    progressHud = hud;
    switch (progressHud) {
        case ARProgressShown: {
          progressHUD = [MBProgressHUD showHUDAddedTo:[APPDELEGATE window] animated:YES];
            progressHUD.label.text = @"Please Wait...";
            
            if ([[APPDELEGATE window].rootViewController isKindOfClass:[UINavigationController class]]) {
                if([[(UINavigationController*)[[APPDELEGATE window] rootViewController] topViewController] isKindOfClass:[StartUpVC class]])
                    progressHUD.yOffset = 150.0;
            }
            progressHUD.mode = MBProgressHUDModeIndeterminate;
        }
            break;
        case ARProgressNotShown:
            break;
        default:
            break;
    }
}

- (void)hideProgressHud {
    [MBProgressHUD hideHUDForView:[APPDELEGATE window] animated:YES];
}

@end
