//
//  FavoriteViewController.m
//  WhatToEat
//
//  Created by Yvonne Luo on 2/18/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import "FavoriteViewController.h"
#import "YPAPISample.h"
#import "Business.h"
#import "FavoriteViewTableViewCell.h"
@interface FavoriteViewController ()
@property (nonatomic, strong) NSArray * biz_arrs;
@property (nonatomic, strong) UILabel * headerLabel;
@end
extern NSString * const SMCombinedTablePaneViewControllerCellReuseIdentifier;
@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[FavoriteViewTableViewCell class]
           forCellReuseIdentifier:SMCombinedTablePaneViewControllerCellReuseIdentifier];

    [self getBusinesses];
    //[self.tableView addSubview:self.headerLabel];
}

-(void)getBusinesses {
    NSString *defaultTerm = @"restaurant";
    NSString *defaultLocation = @"San Francisco, CA";

    //Get the term and location from the command line if there were any, otherwise assign default values.
    NSString *term = [[NSUserDefaults standardUserDefaults] valueForKey:@"term"] ?: defaultTerm;
    NSString *location = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"] ?: defaultLocation;

    YPAPISample *APISample = [[YPAPISample alloc] init];

    dispatch_group_t requestGroup = dispatch_group_create();

    dispatch_group_enter(requestGroup);
    [APISample queryTopBusinessInfoForTerm:term
                                  location:location
                         completionHandler:^(NSDictionary *businesses, NSError *error) {
                             if (error) {
                                 //NSLog(@"An error happened during the request: %@", error);
                             } else if (businesses) {
                                 //NSLog(@"Business array info: \n %@", businesses);
                                 NSMutableArray *arrs = [[NSMutableArray alloc] init];
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"Finished loading business" object:self];
                                 for (id business in businesses) {
                                     Business * biz = [[Business alloc] initWithBizJson:business];
                                     [arrs addObject:biz];
                                 }
                                 _biz_arrs = [[NSArray alloc] initWithArray:arrs];
                             } else {
                                 NSLog(@"No business was found");
                             }

                             dispatch_group_leave(requestGroup);
                         }];
    dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER); // This avoids the program exiting before all our asynchronous callbacks have been made.

}

- (void)loadView {
    [super loadView];

    CGRect frame = self.view.frame;
    CGRect tableViewFrame = frame;

    self.tableView.frame = CGRectIntegral(tableViewFrame);
    self.tableView.backgroundColor = [UIColor blackColor];

    self.tableView.estimatedRowHeight = 170;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.tableView.scrollEnabled = YES;
    self.tableView.bounces = NO;

    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    //[self.headerView addSubview:self.closeButton];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _biz_arrs.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SMCombinedTablePaneViewControllerCellReuseIdentifier forIndexPath:indexPath];
    [cell setBusiness:_biz_arrs[indexPath.row]];
    // Configure the cell...
    
    return cell;
}

-(UILabel *)headerLabel {
    if(!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.text = @"yelpscover";
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.backgroundColor = [UIColor colorWithRed:231.0/255 green:51.0/255 blue:25.0/255 alpha:1];
        _headerLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:35];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _headerLabel;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
