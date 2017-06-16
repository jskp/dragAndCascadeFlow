//
//  YMZCollectionViewCell.m
//  YMZDragCollectionView
//
//  Created by an on 17/6/15.
//  Copyright © 2017年 hua. All rights reserved.
//

#import "YMZCollectionViewCell.h"

@implementation YMZCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backImageView.userInteractionEnabled = YES;

}

@end
