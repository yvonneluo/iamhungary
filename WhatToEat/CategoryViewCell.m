//
//  CategoryViewCell.m
//  WhatToEat
//
//  Created by Yvonne Luo on 2/18/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import "CategoryViewCell.h"

@interface CategoryViewCell()
@property (nonatomic, strong) UIButton * imageButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSString * categoryName;

@end

@implementation CategoryViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        // Add subviews
        [self.contentView addSubview:self.imageButton];
        self.contentView.userInteractionEnabled = NO;
    }
    return self;
}

-(void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];

    if (self.highlighted) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
        CGContextFillRect(context, self.bounds);
    }
}

-(UIButton *)imageButton {
    if (!_imageButton){
        _imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];

        //[_imageButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageButton;

}

-(UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}

-(void)setImageWithName:(NSString *)categoryName {
    NSParameterAssert(categoryName);
    _categoryName = categoryName;

    [self.imageButton setImage:[UIImage imageNamed:_categoryName] forState:UIControlStateNormal];
    /*
    UIImage *image = [UIImage imageNamed: _categoryName];
    [self.imageView setImage:image];
    CGRect frame = self.imageView.frame;
    frame.size.width = 150;
    frame.size.height = 150;
    self.imageView.frame = frame;*/
}
@end
