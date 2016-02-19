//
//  CollectionViewController.m
//  WhatToEat
//
//  Created by Yvonne Luo on 1/17/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import "CollectionViewController.h"
#import "CategoryViewCell.h"

static NSString *kSMInboxMessageDetailsViewCellReuseIdentifier = @"CategoryCellReuseIdentifier";
static UIEdgeInsets SMInboxMessageViewInsets = (UIEdgeInsets){10, 10, 10, 10};

@interface CollectionViewController ()
@property (nonatomic, strong) UILabel * headerLabel;
@property (nonatomic, strong) UICollectionView *categoriesView;
@property (nonatomic, strong) NSMutableArray *categoriesName;
@end

@implementation CollectionViewController
- (instancetype)init
{
    if (self = [super init]) {
        _categoriesName = [[NSMutableArray alloc] init];
        [_categoriesName addObject:@"vegetarian"];
        [_categoriesName addObject:@"chinese"];
        [_categoriesName addObject:@"indian"];
        [_categoriesName addObject:@"pizza"];
        [_categoriesName addObject:@"sushi"];
        [_categoriesName addObject:@"vegetarian"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerLabel];

    [self.collectionView registerClass:[CategoryViewCell class] forCellWithReuseIdentifier:kSMInboxMessageDetailsViewCellReuseIdentifier];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.collectionView.frame = CGRectMake(0, self.headerLabel.frame.size.height+25, screenBounds.size.width, screenBounds.size.height);
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UICollectionView *)collectionView {
    if(!_categoriesView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(150, 150)];
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;

        //[layout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        _categoriesView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

    }
    return _categoriesView;
}

-(UILabel *)headerLabel {
    if(!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.text = @"yelpscover";
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.backgroundColor = [UIColor colorWithRed:231.0/255 green:51.0/255 blue:25.0/255 alpha:1];
        _headerLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:35];
        _headerLabel.textAlignment = NSTextAlignmentCenter;

        CGRect headerFrame = _headerLabel.frame;
        headerFrame.size.width = self.view.frame.size.width;
        headerFrame.size.height = 80;
        _headerLabel.frame = headerFrame;
    }
    return _headerLabel;
}

#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _categoriesName.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CategoryViewCell *cell =
            [self.collectionView dequeueReusableCellWithReuseIdentifier:kSMInboxMessageDetailsViewCellReuseIdentifier
                                                           forIndexPath:indexPath];
    [cell setImageWithName:_categoriesName[indexPath.row]];
    cell.userInteractionEnabled = YES;
    if (indexPath.row %2 == 0) {
        CGRect frame = cell.frame;
        frame.origin.x = 35;
        cell.frame = frame;
    } else {
        CGRect frame = cell.frame;
        frame.origin.x = frame.origin.x -35;
        cell.frame = frame;
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0, 10, 0);
}
@end
