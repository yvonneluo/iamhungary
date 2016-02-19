//
// Created by Yvonne Luo on 1/24/16.
// Copyright (c) 2016 Yvonne Luo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Business : NSObject
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* imageUrl;
@property(nonatomic, strong) NSString* ratingImageUrl;
@property (nonatomic, strong) NSMutableArray* neighborhoods;
@property (nonatomic, assign) NSNumber* reviewCounts;
@property (nonatomic, strong) NSMutableArray* categories;

-(instancetype)initWithBizJson:(id)bizBlob;
@end