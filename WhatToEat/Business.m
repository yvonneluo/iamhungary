//
// Created by Yvonne Luo on 1/24/16.
// Copyright (c) 2016 Yvonne Luo. All rights reserved.
//

#import "Business.h"


@implementation Business {

}

-(instancetype)initWithBizJson:(id)bizBlob {
    if(self =[super init]) {
        _name = [bizBlob objectForKey:@"name"];
        _imageUrl = [bizBlob objectForKey:@"image_url"];
        _ratingImageUrl = bizBlob[@"rating_img_url_large"];
        _categories = bizBlob[@"categories"];
        _neighborhoods = bizBlob[@"location"][@"neighborhoods"];
        _reviewCounts = bizBlob[@"review_count"];


    }
    return self;
}
@end