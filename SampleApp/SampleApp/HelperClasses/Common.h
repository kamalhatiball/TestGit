//
//  Common.h
//  GoNews24x7
//
//  Created by Developer iOS on 05/10/18.
//  Copyright © 2018 Developer IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Common : NSObject

+ (id)sharedInstance;
- (void)playButtonClickSound;
- (void)moveToDashboard;

@end

