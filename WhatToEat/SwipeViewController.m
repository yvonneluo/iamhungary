//
//  SwipeViewController.m
//  WhatToEat
//
//  Created by Yvonne Luo on 1/17/16.
//  Copyright © 2016 Yvonne Luo. All rights reserved.
//

#import "SwipeViewController.h"
#import "DraggableViewBackground.h"

@interface SwipeViewController ()

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
    [self.view addSubview:draggableBackground];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end