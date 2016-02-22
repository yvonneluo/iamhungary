//
//  DataController.h
//  WhatToEat
//
//  Created by Yvonne Luo on 2/21/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface DataController : NSObject
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
- (void)initializeCoreData;

@end
