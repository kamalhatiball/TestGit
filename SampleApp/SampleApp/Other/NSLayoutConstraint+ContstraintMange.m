//
//  NSLayoutConstraint+ContstraintMange.m
//  GoNews24x7
//
//  Created by Geine on 04/05/18.
//  Copyright © 2018 Anshu. All rights reserved.
//

#import "NSLayoutConstraint+ContstraintMange.h"

@implementation NSLayoutConstraint (ContstraintMange)
@dynamic contantVal;

- (void)setContantVal:(CGFloat)cons {
    if (is_iPad) {
        self.constant = cons;
      }
}

@end
