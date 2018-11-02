//
//  CALayer+UIColor.m
//  GoNews24x7
//
//  Created by Developer IOS on 07/07/16.
//  Copyright © 2016 Developer iOS. All rights reserved.
//

#import "CALayer+UIColor.h"

@implementation CALayer (UIColor)


- (void)setBorderUIColor:(UIColor*)color {
    self.borderColor = color.CGColor;
}

- (UIColor*)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
