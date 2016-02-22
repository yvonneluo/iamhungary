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
#import "SavedBusiness.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SavedBusiness"];

    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();

    }
    for (SavedBusiness *business in results) {
        [moc deleteObject:business];
    }
    /*
    SavedBusiness *business = (SavedBusiness *)[NSEntityDescription insertNewObjectForEntityForName:@"SavedBusiness" inManagedObjectContext:moc];
    business.name = @"Test Business";
    business.imageUrl = @"http://s3-media4.ak.yelpcdn.com/dphoto/ShQGf5qi-52HwPiKyZTZ3w/m.jpg";
    business.ratingImageUrl = @"http://s3-media2.fl.yelpcdn.com/assets/2/www/img/ccf2b76faa2c/ico/stars/v1/stars_large_4.png";


    if (![moc save:&error]) {
        // Something's gone seriously wrong
        NSLog(@"Error saving new color: %@", [error localizedDescription]);
    }
    */

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController * tabBarController = [[UITabBarController alloc] init];
    SwipeViewController * firstViewController = [[SwipeViewController alloc]init];
    CollectionViewController *collectionViewController = [[CollectionViewController alloc]init];
    FavoriteViewController *favoriteViewController = [[FavoriteViewController alloc]init];
    NSArray *controllers = [NSArray arrayWithObjects:collectionViewController, firstViewController, favoriteViewController, nil];
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

#pragma  managed context
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Yvonne.ManagedProject" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    // Create the coordinator and store

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ManagedProject2.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}


@end
