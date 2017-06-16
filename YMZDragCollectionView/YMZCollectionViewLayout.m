//
//  YMZCollectionViewLayout.m
//  YMZDragCollectionView
//
//  Created by an on 17/6/15.
//  Copyright © 2017年 hua. All rights reserved.
//

#import "YMZCollectionViewLayout.h"
#define APPW  [UIScreen mainScreen].bounds.size.width
#define column 3
#define margin 10
@interface YMZCollectionViewLayout()
@property (nonatomic ,strong)NSMutableArray *layoutArray;
@property (nonatomic ,strong)NSMutableArray *rowCollums;//保存每列的高度,
@property (nonatomic ,assign)CGFloat lowcollum;
@property (nonatomic ,assign)CGFloat ViewHeight;
@end
@implementation YMZCollectionViewLayout
-(void)prepareLayout{
    
    // 获取layout 的 colletionView
    UICollectionView *collcetionView = self.collectionView;
    collcetionView.backgroundColor = [UIColor whiteColor];
    [self.layoutArray removeAllObjects];
    // 初始化的时候每一列的高度都是 10 
    self.rowCollums  = [NSMutableArray arrayWithObjects:@(10),@(10),@(10), nil];
    // 获取有多少 item
    NSInteger numberItem = [collcetionView numberOfItemsInSection:0];
    for(int a = 0; a<numberItem;a++){
        
        [self.layoutArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:a inSection:0]]];
    }
    
    
}
-(CGSize)collectionViewContentSize{
    if (self.rowCollums) {
        NSInteger height = 0;
        NSLog(@"开始的值是多少 %ld",height);
        for (int a = 0; a<self.rowCollums.count-1; a++) {
            if ([self.rowCollums[height] floatValue]<[self.rowCollums[a+1] floatValue]) {
                
                height = a+1;
            }
        }
        CGFloat maxHeight = [self.rowCollums[height] floatValue];
        return  CGSizeMake(0,maxHeight);
        
    }else{
        return CGSizeZero;
    }

}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes * layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = ((APPW - (column+1)*margin)/column);
    CGFloat height =0;
    if ([self.delegate respondsToSelector:@selector(getHeightThroughWidth: andIndex:)]) {
        height = [self.delegate getHeightThroughWidth:width andIndex:indexPath];
    }
    int number = 0 ;
    for (int a = 0 ; a<self.rowCollums.count-1; a++) {
        if ([self.rowCollums[number] doubleValue]>[self.rowCollums[a+1] doubleValue]) {
            number = a+1;
        }
    }
    CGFloat X = margin + number *(margin + width);
    CGFloat Y = [self.rowCollums[number] doubleValue];
    CGFloat jj = [self.rowCollums[number] doubleValue]+height+margin;
    self.rowCollums[number] = @(jj);
    layoutAttributes.frame = CGRectMake(X, Y, width, height);
    return layoutAttributes;
    
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.layoutArray;
}
-(NSMutableArray *)layoutArray{
    
    if (!_layoutArray) {
        _layoutArray = [NSMutableArray array];
    }
    return _layoutArray;
}

@end
