//
//  OptionsPickerSheetView.m
//  VPW
//
//  Created by 15/3/17 on 27/07/16.
//  Copyright © 2017 Anshu. All rights reserved.
//

#import "OptionsPickerSheetView.h"
#import "AppDelegate.h"

OptionPickerSheetBlock optionPickerBlock;
UIPickerView *picker;
NSInteger     currentPick;
NSArray      *pickerOptions;

static OptionsPickerSheetView *optionsPickerSheetView = nil;
@implementation OptionsPickerSheetView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


+ (id)sharedPicker {
    
    if (!optionsPickerSheetView) {
        
        optionsPickerSheetView = [[OptionsPickerSheetView alloc] init];
    }
    
    return optionsPickerSheetView;
}


-(void)showPickerSheetWithOptions:(NSArray *)options AndComplitionblock:(OptionPickerSheetBlock)block
{
    [self endEditing:YES];
    optionPickerBlock = [block copy];
    
    pickerOptions = [[NSArray alloc] initWithArray:options];

    currentPick = 0;
    
        picker = [[UIPickerView alloc] init];
        picker.showsSelectionIndicator =  YES;
        picker.delegate = self;
        picker.dataSource = self;
        
        
        [optionsPickerSheetView addSubview:picker];
    
      [picker setFrame:CGRectMake(0, 40, appDelegate.window.frame.size.width, 216)];

        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(5, 0, appDelegate.window.frame.size.width-10, 40)];
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneActionSheet:)];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelActionSheet:)];
        UIBarButtonItem *flexibleSpace =   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar setItems: [NSArray arrayWithObjects:cancelBtn,flexibleSpace,doneBtn, nil] animated:NO];
        [optionsPickerSheetView addSubview:toolBar];
        
    [picker selectRow:currentPick inComponent:0 animated:NO];
    
    [picker setFrame:CGRectMake(0, 40, appDelegate.window.frame.size.width, 216)];
    
    [picker setBackgroundColor:[UIColor clearColor]];
    [picker reloadAllComponents];
    
    
    UIView *tempView = [[UIView alloc] initWithFrame:appDelegate.window.bounds];
    [tempView setBackgroundColor:[UIColor blackColor]];
    [tempView setAlpha:0.0];
    [tempView setTag:786];
    
    
    [appDelegate.window addSubview:tempView];
    
    [appDelegate.window addSubview:optionsPickerSheetView];
    [appDelegate.window bringSubviewToFront:optionsPickerSheetView];
    
    optionsPickerSheetView.frame = CGRectMake(0, appDelegate.window.frame.size.height, appDelegate.window.frame.size.width, 260);
    
    [UIView animateWithDuration:0.1 animations:^{
        optionsPickerSheetView.frame = CGRectMake(0, appDelegate.window.frame.size.height -260, appDelegate.window.frame.size.width, 260);
        [tempView setAlpha:0.50];
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

-(void)cancelActionSheet:(id)sender{
    [self removePickerView];
}
#pragma mark - Action Sheet Callback function
-(void)doneActionSheet:(id)sender{
    
    optionPickerBlock([pickerOptions objectAtIndex:currentPick],currentPick);
    [self removePickerView];
}

-(void)removePickerView {

    [UIView animateWithDuration:0.1 animations:^{
        optionsPickerSheetView.frame = CGRectMake(0, appDelegate.window.frame.size.height, appDelegate.window.frame.size.width, 260);
        
    } completion:^(BOOL finished) {
        for (id obj  in optionsPickerSheetView.subviews) {
            [obj removeFromSuperview];
        }
        [optionsPickerSheetView removeFromSuperview];
        optionsPickerSheetView =nil;
        [[appDelegate.window viewWithTag:786] removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDelegate

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  [pickerOptions count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    currentPick = row;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    
    if (!label) {
        // Customize your label (or any other type UIView) here
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 5.0f, pickerView.bounds.size.width * 0.8, 25.0f)];
        
        [label setTextAlignment:NSTextAlignmentCenter];
    }
    
    [label setBackgroundColor:[UIColor clearColor]];
    if(SCREEN_WIDTH == 320)
        [label setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    else if (SCREEN_WIDTH == 375)
        [label setFont:[UIFont fontWithName:@"Helvetica" size:17.0f]];
    else
        [label setFont:[UIFont fontWithName:@"Helvetica" size:19.0f]];
    if (row < [pickerOptions count])
    {
        label.text = (NSString *)[pickerOptions objectAtIndex:row];
        
    }
    return label;
}

@end
