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
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface FavoriteViewController ()

@property (nonatomic, strong) NSArray * biz_arrs;
@property (nonatomic, strong) UILabel * headerLabel;
@property (nonatomic, strong) UIImageView* headerImage;

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
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SavedBusiness"];

    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    _biz_arrs = [[NSArray alloc] initWithArray:results];
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
    self.tableView.bounces = YES;
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
    return self.headerImage;
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
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.text = @"yelpscover";
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.backgroundColor = [UIColor colorWithRed:231.0 / 255 green:51.0 / 255 blue:25.0 / 255 alpha:1];
        _headerLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:35];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _headerLabel;

}

-(UIImageView *)headerImage{
    if(!_headerImage){
        _headerImage= [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"header"]];
        CGRect headerFrame = _headerImage.frame;
        headerFrame.size.width = self.view.frame.size.width;
        //headerFrame.size.height = 80;
        _headerImage.frame = headerFrame;
    }
    return _headerImage;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;

    CGFloat contentYoffset = scrollView.contentOffset.y;

    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;

    if(distanceFromBottom < height)
    {
        NSLog(@"end of the table");
    }
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
