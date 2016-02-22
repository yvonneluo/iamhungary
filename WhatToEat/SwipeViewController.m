//
//  SwipeViewController.m
//  WhatToEat
//
//  Created by Yvonne Luo on 1/17/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import "SwipeViewController.h"
#import "DraggableViewBackground.h"
#import "YPAPISample.h"
#import "Business.h"
@interface SwipeViewController ()
@property (nonatomic, strong) NSArray * biz_arrs;
@property (nonatomic, strong) DraggableViewBackground* draggableViewBackground;
@property (nonatomic, strong) UIView *loadingView;
@end

@implementation SwipeViewController
- (void)viewWillDisappear:(BOOL) animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)viewWillAppear:(BOOL)animated {

    if (_searchTerm && ![[[NSUserDefaults standardUserDefaults] valueForKey:@"last_search_term"] isEqualToString:_searchTerm]){
        //[self.view addSubview:self.loadingView];

        NSLog(@"Search term changed");
        [self.draggableViewBackground removeFromSuperview];
        [self searchYelpApiWithTerm];
        _draggableViewBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame responseDictionary:_biz_arrs];
        [self.view addSubview:_draggableViewBackground];
        [self.view bringSubviewToFront:_draggableViewBackground];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"Finished loading business"
                                               object:nil];

    NSString *defaultTerm = @"lolo";
    NSString *defaultLocation = @"San Francisco, CA";

    //Get the term and location from the command line if there were any, otherwise assign default values.
    NSString *term = _searchTerm ?: defaultTerm;
    [[NSUserDefaults standardUserDefaults] setObject:term forKey:@"last_search_term"];


    NSString *location = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"] ?: defaultLocation;

    YPAPISample *APISample = [[YPAPISample alloc] init];

    dispatch_group_t requestGroup = dispatch_group_create();

    dispatch_group_enter(requestGroup);
    [APISample queryTopBusinessInfoForTerm:term
                                  location:location
                         completionHandler:^(NSDictionary *businesses, NSError *error) {
        if (error) {
            NSLog(@"An error happened during the request: %@", error);
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
    //[self searchYelpApiWithTerm];
    _draggableViewBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame responseDictionary:_biz_arrs];
    [self.view addSubview:_draggableViewBackground];
    [self.view bringSubviewToFront:_draggableViewBackground];
}


-(UIView *)loadingView {
    if(!_loadingView){
        _loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
        _loadingView.backgroundColor = [UIColor yellowColor];
    }
    return _loadingView;
}

- (void)searchYelpApiWithTerm{
    NSString *defaultTerm = @"lolo";
    NSString *defaultLocation = @"San Francisco, CA";

    //Get the term and location from the command line if there were any, otherwise assign default values.
    NSString *term = _searchTerm ?: defaultTerm;
    [[NSUserDefaults standardUserDefaults] setObject:term forKey:@"last_search_term"];


    NSString *location = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"] ?: defaultLocation;

    YPAPISample *APISample = [[YPAPISample alloc] init];

    dispatch_group_t requestGroup = dispatch_group_create();

    dispatch_group_enter(requestGroup);
    [APISample queryTopBusinessInfoForTerm:term
                                  location:location
                         completionHandler:^(NSDictionary *businesses, NSError *error) {
                             if (error) {
                                 NSLog(@"An error happened during the request: %@", error);
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

// TODO: yvonne this doesn't update the UI for some reason
- (void)receivedNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"Finished loading business"]) {
        // TODO: yvonne this doesn't update the UI for some reason
        /*
        DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame responseDictionary:_businesses];
        [self.view addSubview:draggableBackground];
        [self.view bringSubviewToFront:draggableBackground];*/
    } else if ([[notification name] isEqualToString:@"Not Found"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Results Found"
                                                            message:nil delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
