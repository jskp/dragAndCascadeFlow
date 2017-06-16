//
//  ViewController.m
//  YMZDragCollectionView
//
//  Created by an on 17/6/15.
//  Copyright © 2017年 hua. All rights reserved.
//

#import "ViewController.h"
#import "YMZCollectionView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YMZCollectionView *collectionView = [[YMZCollectionView alloc] initWithFrame:self.view.bounds];
    collectionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:collectionView];
    
}

@end
