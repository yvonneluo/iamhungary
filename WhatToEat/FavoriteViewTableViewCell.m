//
//  FavoriteViewTableViewCell.m
//  WhatToEat
//
//  Created by Yvonne Luo on 2/18/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import "FavoriteViewTableViewCell.h"
#import "SavedBusiness.h"
NSString * const SMCombinedTablePaneViewControllerCellReuseIdentifier = @"SMCombinedTableViewControllerCellReuseIdentifier";
CGFloat const xOffset = 150;
CGFloat const yOffsetForRating = 15;
CGFloat const yOffsetForNeighborhood = 65;
CGFloat const yOffsetForCagegories = 90;

@interface FavoriteViewTableViewCell()
@property (nonatomic, strong) Business *business;
@property (nonatomic, strong) UIImageView *bizPhoto;
@property (nonatomic, strong) UILabel *bizName;
@property (nonatomic, strong) UIImageView *bizRatingImage;
@property (nonatomic, strong) UILabel *neightborhoodLabel;
@property (nonatomic, strong) UILabel *reviewCountLabel;
@property (nonatomic, strong) UILabel *categoriLabel;

@end

@implementation FavoriteViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];

    for(UIView *subview in [self.contentView subviews]) {
        [subview removeFromSuperview];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if(_business) {
        [self.contentView addSubview:self.bizName];
        [self.contentView addSubview:self.bizPhoto];
        [self.contentView addSubview:self.bizRatingImage];
        [self.contentView addSubview:self.reviewCountLabel];
        [self.contentView addSubview:self.neightborhoodLabel];
        [self.contentView addSubview:self.categoriLabel];
    }
}

- (void)setBusiness:(nonnull SavedBusiness *)business {
    NSParameterAssert(business);
    _business = business;
    self.bizName.text = _business.name;
    self.reviewCountLabel.text = [[_business.reviewCounts stringValue] stringByAppendingString:@" reviews"];
    int i = 0;
    self.neightborhoodLabel.text = @"";
    /*
    for (; i< [_business.neighborhoods count] -1; i++) {
        self.neightborhoodLabel.text = [self.neightborhoodLabel.text stringByAppendingString:_business.neighborhoods[i]];
        self.neightborhoodLabel.text = [self.neightborhoodLabel.text stringByAppendingString:@", "];
    }
    self.neightborhoodLabel.text = [self.neightborhoodLabel.text stringByAppendingString:_business.neighborhoods[i]];

    i = 0;
    self.categoriLabel.text = @"";
    for (; i< [_business.categories count] -1; i++) {
        self.categoriLabel.text = [self.categoriLabel.text stringByAppendingString:_business.categories[i][0]];
        self.categoriLabel.text = [self.categoriLabel.text stringByAppendingString:@", "];
    }
    self.categoriLabel.text = [self.categoriLabel.text stringByAppendingString:_business.categories[i][0]];*/

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(UILabel *)bizName {
    if(!_bizName) {
        _bizName = [[UILabel alloc] init];
        _bizName.textColor = [UIColor blackColor];
        _bizName.font = [UIFont fontWithName:@"Helvetica-Light" size:16];
        _bizName.numberOfLines = 0;
        [_bizName sizeToFit];
        _bizName.lineBreakMode = NSLineBreakByWordWrapping;


        CGRect headerFrame = _bizName.frame;
        headerFrame.size.width = self.contentView.frame.size.width - xOffset - 10;
        headerFrame.size.height = 40;
        headerFrame.origin.x = xOffset;
        headerFrame.origin.y = 15;
        _bizName.frame = headerFrame;
    }
    return _bizName;
}


-(UILabel *)reviewCountLabel {
    if(!_reviewCountLabel) {
        _reviewCountLabel = [[UILabel alloc] init];
        _reviewCountLabel.textColor = [UIColor blackColor];
        _reviewCountLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];

        CGRect headerFrame = _reviewCountLabel.frame;
        headerFrame.size.width = self.contentView.frame.size.width - xOffset - self.bizRatingImage.frame.size.width - 15;
        headerFrame.size.height = 20;
        headerFrame.origin.x = xOffset + self.bizRatingImage.frame.size.width + 15;
        headerFrame.origin.y = self.bizName.frame.size.height + yOffsetForRating;
        _reviewCountLabel.frame = headerFrame;
    }
    return _reviewCountLabel;
}


-(UILabel *)neightborhoodLabel {
    if(!_neightborhoodLabel) {
        _neightborhoodLabel = [[UILabel alloc] init];
        _neightborhoodLabel.textColor = [UIColor blackColor];
        _neightborhoodLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
        _neightborhoodLabel.text = @"";
        CGRect headerFrame = _neightborhoodLabel.frame;
        headerFrame.size.width = self.contentView.frame.size.width - xOffset;
        headerFrame.size.height = 30;
        headerFrame.origin.x = xOffset;
        headerFrame.origin.y = self.bizName.frame.size.height + yOffsetForRating + self.reviewCountLabel.frame.size.height;
        _neightborhoodLabel.numberOfLines = 0;
        [_neightborhoodLabel sizeToFit];
        _neightborhoodLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _neightborhoodLabel.frame = headerFrame;
    }
    return _neightborhoodLabel;
}

-(UILabel *)categoriLabel {
    if(!_categoriLabel) {
        _categoriLabel = [[UILabel alloc] init];
        _categoriLabel.textColor = [UIColor blackColor];
        _categoriLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
        _categoriLabel.text = @"";
        CGRect headerFrame = _categoriLabel.frame;
        headerFrame.size.width = self.contentView.frame.size.width - xOffset;

        headerFrame.origin.x = xOffset;
        headerFrame.origin.y = self.bizName.frame.size.height + yOffsetForRating + self.reviewCountLabel.frame.size.height + self.neightborhoodLabel.frame.size.height;

        [_categoriLabel sizeToFit];
        _categoriLabel.numberOfLines = 0;
        _categoriLabel.lineBreakMode = NSLineBreakByWordWrapping;

        _categoriLabel.frame = headerFrame;
    }
    return _categoriLabel;
}

-(UIImageView *)bizRatingImage{
    if (!_bizRatingImage) {
        _bizRatingImage = [[UIImageView alloc] init];
        NSString *imageUrl = _business.ratingImageUrl;
        NSURL *imageURL = [NSURL URLWithString:imageUrl];
        NSError* error = nil;
        NSData* imageData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);

        } else {
            //NSLog(@"Data has loaded successfully.");
        }

        UIImage * image = [UIImage imageWithData:imageData];
        _bizRatingImage.image = image;

        CGRect imageFrame = _bizRatingImage.frame;
        imageFrame.size.width = 83;
        imageFrame.size.height = 15;
        //CGFloat width = [UIScreen mainScreen].bounds.size.width;
        imageFrame.origin.x = xOffset;//(width - imageFrame.size.width) /2;
        imageFrame.origin.y = self.bizName.frame.size.height + yOffsetForRating + 3;
        _bizRatingImage.frame = imageFrame;
    }
    return _bizRatingImage;
}

-(UIImageView *)bizPhoto {
    if(!_bizPhoto) {
        _bizPhoto = [[UIImageView alloc] init];
        NSString *imageUrl = _business.imageUrl;
        NSString * newUrl = [imageUrl substringWithRange:NSMakeRange(0, [imageUrl length]-6)];
        NSString * newImageUrl = [newUrl stringByAppendingString:@"ls.jpg"];

        NSParameterAssert(newImageUrl);
        NSURL *imageURL = [NSURL URLWithString:newImageUrl];
        //NSURL *imageURL = [NSURL URLWithString:@"http://s3-media4.fl.yelpcdn.com/bphoto/uweSiOf0XBB4BPk_ibHVyg/o.jpg"];

        NSError* error = nil;
        NSData* imageData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);

        } else {
            //NSLog(@"Data has loaded successfully.");
        }

        UIImage * image = [UIImage imageWithData:imageData];
        _bizPhoto.image = image;

        CGRect imageFrame = _bizPhoto.frame;
        imageFrame.size.width = 120;
        imageFrame.size.height = 120;
        //CGFloat width = [UIScreen mainScreen].bounds.size.width;
        imageFrame.origin.x = 15;//(width - imageFrame.size.width) /2;
        imageFrame.origin.y = 15;
        _bizPhoto.frame = imageFrame;
    }
    return _bizPhoto;
}
@end
