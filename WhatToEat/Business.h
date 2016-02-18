//
// Created by Yvonne Luo on 1/24/16.
// Copyright (c) 2016 Yvonne Luo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Business : NSObject
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* imageUrl;

-(instancetype)initWithName:(NSString *)name imageUrl:(NSString *)imageUrl;
-(instancetype)initWithBizJson:(id)bizBlob;
@end