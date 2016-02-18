//
// Created by Yvonne Luo on 1/24/16.
// Copyright (c) 2016 Yvonne Luo. All rights reserved.
//

#import "Business.h"


@implementation Business {

}
-(instancetype)initWithName:(NSString *)name imageUrl:(NSString *)imageUrl {
    if(self =[super init]) {
        _name = name;
        _imageUrl = imageUrl;
    }
    return self;
}

-(instancetype)initWithBizJson:(id)bizBlob {
    if(self =[super init]) {
        _name = bizBlob[@'name'];
        _imageUrl = bizBlob[@'imageUrl'];
    }
    return self;
}
@end