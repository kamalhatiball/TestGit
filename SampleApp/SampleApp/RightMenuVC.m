//
//  RightMenuVC.m
//  SampleApp
//
//  Created by Developer iOS on 01/11/18.
//  Copyright © 2018 Developer IOS. All rights reserved.
//

#import "RightMenuVC.h"

@interface RightMenuVC ()<UISearchControllerDelegate> {
    
    
    NSMutableArray *menuTableArray;
    NSMutableArray *filteredContentList;
    BOOL isSearching;
}

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *menuSearchBar;
//@property (weak, nonatomic) IBOutlet UISearchDisplayController *searchBarController;

@end

@implementation RightMenuVC
@synthesize menuSearchBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* Navigation Bar setup */
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [[[self navigationController] navigationBar] setBarTintColor: [UIColor redColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *menuButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setFrame:CGRectMake(0, 10, 30, 30)];
    [menuButton addTarget:self action:@selector(hideLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [menuButton setImage:[UIImage imageNamed:@"close_cross"] forState:UIControlStateNormal];
    UIBarButtonItem *menubarButton = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    menuButton.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 2, 10);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    imageView.image = [UIImage imageNamed:@"Gonews_heder_logo.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationController.navigationBar.topItem.titleView = imageView;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = menubarButton;
    menuTableArray = [[NSMutableArray alloc] initWithObjects:@"PERSONALIZE NEWS", @"ALL VIDEOS", @"LIVE STREAMING", @"PROFILE", @"TELL A FRIEND", @"HELP", @"SETTINGS", @"DELETE PFOFILE", nil];
    
    //menuTableArray = [[NSMutableArray alloc] initWithObjects:@"Login", @"About", @"Rating", @"Enquiry", @"Tutorial", @"Share", @"Send", nil ];
    
}

- (void)hideLeftMenu:(UIButton *)sender {
    [self.sideMenuController hideLeftView];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (tableView.frame.size.height-50)/menuTableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearching) {
        return [filteredContentList count];
    }
    return menuTableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"menuTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UILabel *type = (UILabel*)[cell viewWithTag:101];
    if (isSearching)
        type.text = [filteredContentList objectAtIndex:indexPath.row];
    else
        type.text = [menuTableArray objectAtIndex:indexPath.row];
    
    if (is_iPad)
        type.font = [UIFont boldSystemFontOfSize:24.0];
    else
        type.font = [UIFont boldSystemFontOfSize:18.0];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    UIView *selected = [[UIView alloc] init];
    selected.backgroundColor= [UIColor clearColor];
    cell.selectedBackgroundView = selected;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Passmenu" object:self userInfo:@{@"row": [NSString stringWithFormat:@"%ld", indexPath.row]}];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);
    
    //Remove all objects first.
    [filteredContentList removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
    }
    else {
        isSearching = NO;
    }
    [self.menuTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}

- (void)searchTableList {
    NSString *searchString = menuSearchBar.text;
    
    for (NSString *tempStr in menuTableArray) {
        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [filteredContentList addObject:tempStr];
        }
    }
}

@end

/*
 - (void)willPresentSearchController:(UISearchController *)searchController;
 - (void)didPresentSearchController:(UISearchController *)searchController;
 - (void)willDismissSearchController:(UISearchController *)searchController;
 - (void)didDismissSearchController:(UISearchController *)searchController;
 
 // Called after the search controller's search bar has agreed to begin editing or when 'active' is set to YES. If you choose not to present the controller yourself or do not implement this method, a default presentation is performed on your behalf.
 - (void)presentSearchController:(UISearchController *)searchController;
 
 */
