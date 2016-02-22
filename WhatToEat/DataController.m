//
//  DataController.m
//  WhatToEat
//
//  Created by Yvonne Luo on 2/21/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import "DataController.h"
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@implementation DataController
- (id) init {

    self = [super init];
    if (!self) return nil;

    [self initializeCoreData];

    return self;
}

- (void)initializeCoreData {
}

@end
