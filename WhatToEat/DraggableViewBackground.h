//
//  DraggableViewBackground.h
//  WhatToEat
//
//  Created by Yvonne Luo on 1/17/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableView.h"

@interface DraggableViewBackground : UIView <DraggableViewDelegate>

//methods called in DraggableView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;
- (id)initWithFrame:(CGRect)frame responseDictionary:(NSDictionary *)businesses;

@property (retain,nonatomic)NSArray* exampleCardLabels; //%%% the labels the cards
@property (retain,nonatomic)NSMutableArray* allCards; //%%% the labels the cards


@end