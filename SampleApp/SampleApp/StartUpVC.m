//
//  StartUpVC.m
//  SampleApp
//
//  Created by Developer iOS on 26/10/18.
//  Copyright © 2018 Developer IOS. All rights reserved.
//

#import "StartUpVC.h"

@interface StartUpVC ()

@end

@implementation StartUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[Common sharedInstance] moveToDashboard];
}

@end
