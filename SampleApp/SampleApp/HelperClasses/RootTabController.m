//
//  RootTabController.m
//  SampleApp
//
//  Created by Developer iOS on 29/10/18.
//  Copyright © 2018 Developer IOS. All rights reserved.
//

#import "RootTabController.h"

@interface RootTabController () {
    
}
@end

@implementation RootTabController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.delegate = self;
    
    UIViewController *vc1 = [self.viewControllers objectAtIndex:0];
    UIViewController *vc2 = [self.viewControllers objectAtIndex:1];
    UIViewController *vc3 = [self.viewControllers objectAtIndex:2];
    UIViewController *vc4 = [UIViewController new];
    vc4.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:4];
    [self setViewControllers:@[vc1, vc2, vc3, vc4]];
    
    /* Navigation Bar setup */
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [[[self navigationController] navigationBar] setBarTintColor: [UIColor redColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *menuButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setFrame:CGRectMake(0, 10, 30, 30)];
    [menuButton addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    UIBarButtonItem *menubarButton = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    menuButton.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 2, 10);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    imageView.image = [UIImage imageNamed:@"Gonews_heder_logo.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationController.navigationBar.topItem.titleView = imageView;
    
    UIButton *menu_dotButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [menu_dotButton setFrame:CGRectMake(0, 5, 40, 40)];
    [menu_dotButton addTarget:self action:@selector(watchVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    [menu_dotButton setImage:[UIImage imageNamed:@"watch_video_icon"] forState:UIControlStateNormal];
    UIBarButtonItem *menu_dotButtonBar = [[UIBarButtonItem alloc] initWithCustomView:menu_dotButton];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = menubarButton;
    self.navigationItem.rightBarButtonItem = menu_dotButtonBar;
}

#pragma mark - header Action

- (IBAction)menuBtnAction:(id)sender {
    if (!self.sideMenuController.isLeftViewVisible) {
        [self.sideMenuController showLeftView];
    }
}

- (IBAction)watchVideoAction:(id)sender {
    if (self.sideMenuController.isRightViewVisible)
        [self.sideMenuController hideLeftView];
    else
        [self.sideMenuController showLeftView];
}

- (IBAction)introViewClick:(UITapGestureRecognizer *)gesture {
    [UIView animateWithDuration:0.5 animations:^{
        [[self navigationController] setNavigationBarHidden:NO animated:NO];
    }];
}


#pragma mark - Delegate Methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    NSUInteger indexOfTab = [self.viewControllers indexOfObject:viewController];
    
    if ((int)indexOfTab == 3) {
        
        //UITabBarItem *item = [self.tabBar.items objectAtIndex:indexOfTab];
        
        UIViewController *newViewCont = [[UIViewController  alloc] init];
        newViewCont.view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 180, 180)];
        newViewCont.modalPresentationStyle = UIModalPresentationPopover;
        
        [self presentViewController:newViewCont animated:YES completion:nil];
        
        UIPopoverPresentationController *pop = [newViewCont popoverPresentationController];
        pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
        [pop setSourceView:appDelegate.window.rootViewController.view];
        [pop setSourceRect:CGRectMake(SCREEN_WIDTH-50, SCREEN_HEIGHT - 150, 50, 50)];
        
        
       /* [[ARPopMenu shared] showMenuWithOption:@[@"D", @"E", @"F"] origin:CGPointMake(SCREEN_WIDTH-50, SCREEN_HEIGHT - 150) images:@[@"school", @"goverment", @"contactphone"] backgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:.8] textColor:[UIColor whiteColor] imageColor:[UIColor grayColor] isMultiLineTitle:NO isHaveSeparator:NO WithComptionBlock:^(NSInteger selectedIndex) {
            
            switch (selectedIndex) {
                case 0:
                    
                    break;
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                    
                default:
                    break;
            }
        }];*/
        
        return NO;
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSUInteger indexOfTab = [self.viewControllers indexOfObject:viewController];
    NSLog(@"Tab index = %u (%u)", (int)indexOfTab);
}



@end
