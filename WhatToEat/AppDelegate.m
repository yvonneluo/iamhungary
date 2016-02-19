//
//  AppDelegate.m
//  WhatToEat
//
//  Created by Yvonne Luo on 1/17/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import "AppDelegate.h"
#import "SwipeViewController.h"
#import "CollectionViewController.h"
#import "FavoriteViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController * tabBarController = [[UITabBarController alloc] init];

    SwipeViewController * firstViewController = [[SwipeViewController alloc]init];
    CollectionViewController *collectionViewController = [[CollectionViewController alloc]init];

    FavoriteViewController *favoriteViewController = [[FavoriteViewController alloc]init];
    //NSArray *controllers = [NSArray arrayWithObjects:firstViewController, collectionViewController, nil];

    NSArray *controllers = [NSArray arrayWithObjects:firstViewController, collectionViewController, favoriteViewController, nil];
    tabBarController.viewControllers=controllers;

    // Change the tab bar background color
    tabBarController.tabBar.barTintColor =  [UIColor colorWithRed:41/255.0 green:41/255.0 blue:41/255.0 alpha:1];//[UIColor darkGrayColor];

    [[UITabBar appearance] setSelectedImageTintColor: [UIColor whiteColor]];
    NSArray* items = [tabBarController.tabBar items];

    UITabBarItem * tabBarItem = [items objectAtIndex:0];
    [tabBarItem setTitle:@"Search"];
    UIImage *iconImage = [UIImage imageNamed:@"profileclear"];


    UITabBarItem * tabBarItem1 = [items objectAtIndex:1];
    [tabBarItem1 setTitle:@"Home"];
    UIImage *collectionViewIcon = [UIImage imageNamed:@"homeclear"];

    UITabBarItem * tabBarItem2 = [items objectAtIndex:2];
    [tabBarItem2 setTitle:@"Favorite"];
    UIImage *collectionViewIcon2 = [UIImage imageNamed:@"favoriteclear"];

    [tabBarItem setImage:iconImage];
    [tabBarItem1 setImage:collectionViewIcon];
    [tabBarItem2 setImage:collectionViewIcon2];


    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
