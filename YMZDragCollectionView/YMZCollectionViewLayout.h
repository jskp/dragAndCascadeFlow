//
//  YMZCollectionViewLayout.h
//  YMZDragCollectionView
//
//  Created by an on 17/6/15.
//  Copyright © 2017年 hua. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YMZCollectionViewLayoutDelegate <NSObject>
-(CGFloat)getHeightThroughWidth:(CGFloat)weight andIndex:(NSIndexPath *)indexPath;
@end
@interface YMZCollectionViewLayout : UICollectionViewLayout
@property (nonatomic ,weak)id<YMZCollectionViewLayoutDelegate>delegate;
@end
