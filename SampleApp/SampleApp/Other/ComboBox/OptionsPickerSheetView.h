//
//  OptionsPickerSheetView.m
//  VPW
//
//  Created by Anshu on 15/3/17.
//  Copyright © 2017 15/3/17. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OptionPickerSheetBlock)(NSString  *selectedText,NSInteger selectedIndex);

@interface OptionsPickerSheetView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

+ (id)sharedPicker;

-(void)showPickerSheetWithOptions:(NSArray *)options AndComplitionblock:(OptionPickerSheetBlock )block;

@end
