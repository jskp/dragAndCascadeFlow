//
//  YMZCollectionView.m
//  YMZDragCollectionView
//
//  Created by an on 17/6/15.
//  Copyright © 2017年 hua. All rights reserved.
//

#import "YMZCollectionView.h"
#import "YMZCollectionViewCell.h"
#import "YMZCollectionViewLayout.h"
#define APPW  [UIScreen mainScreen].bounds.size.width
#define APPH  [UIScreen mainScreen].bounds.size.height

static NSString * identifier = @"Identifier";
@interface YMZCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,YMZCollectionViewLayoutDelegate>
@property(nonatomic ,strong)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic ,strong)YMZCollectionViewLayout *customerLayout;
@property(nonatomic ,strong)UILongPressGestureRecognizer *longGesture;
@property(nonatomic ,strong)UIPanGestureRecognizer *panGesture;
@property(nonatomic ,strong)NSMutableArray *dataArray;

@end
@implementation YMZCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *bnt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bnt setTitle:@"开始拖拽" forState:UIControlStateNormal];
        bnt.frame = CGRectMake(0, 20, APPW, 20);
        bnt.backgroundColor = [UIColor cyanColor];
        [bnt addTarget:self action:@selector(changeLayout:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bnt];
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
#pragma mark UICollectionViewDataSource and UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YMZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    cell.backImageView.image = image;
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    id obj = [self.dataArray objectAtIndex:sourceIndexPath.row];
    [self.dataArray removeObjectAtIndex:sourceIndexPath.row];
    [self.dataArray insertObject:obj atIndex:destinationIndexPath.row];
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YMZCollectionViewCell *YMZCell = (YMZCollectionViewCell *)cell;
    if ([collectionView.collectionViewLayout isEqual:self.customerLayout]) {
        [YMZCell.layer removeAllAnimations];
    }else{
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath = @"transform.rotation";
        keyAnimation.values = @[@(-0.03),@(0.03)];
        keyAnimation.repeatCount = MAXFLOAT;
        keyAnimation.duration = 0.2f;
        [YMZCell.layer addAnimation:keyAnimation forKey:@""];
        
        
    }
    
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark YMZCollectionViewLayoutDelegate
-(CGFloat)getHeightThroughWidth:(CGFloat)weight andIndex:(NSIndexPath *)indexPath{
    UIImage *image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    return weight*image.size.height/image.size.width;
}

-(void)handleMethod:(UIPanGestureRecognizer *)gesture{
    CGPoint location = [gesture locationInView:self.collectionView];
    NSIndexPath *indexpath = [self.collectionView indexPathForItemAtPoint:location];
    if (indexpath) {
        switch (gesture.state) {
            case UIGestureRecognizerStateBegan:
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexpath];
                break;
            case UIGestureRecognizerStateChanged:
                [self.collectionView updateInteractiveMovementTargetPosition:location];
                break;
            default:
                break;
        }
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.collectionView endInteractiveMovement];
    }
}


#pragma mark getter and setter
-(UILongPressGestureRecognizer *)longGesture{
    if (!_longGesture) {
        _longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleMethod:)];
    }
    return _longGesture;
    
}

-(UIPanGestureRecognizer *)panGesture{
    
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMethod:)];
    }
    
    return _panGesture;
}
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5", @"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",nil];
    }
    
    return _dataArray;
}
-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.itemSize = CGSizeMake(100, 100);
        _flowLayout.minimumLineSpacing = 10.0f;
        _flowLayout.minimumInteritemSpacing = 0.0f;
    }
    return _flowLayout;
}
-(YMZCollectionViewLayout *)customerLayout{
    
    if (!_customerLayout) {
        _customerLayout = [[YMZCollectionViewLayout alloc]init];
        _customerLayout.delegate = self;
        
    }
    return _customerLayout;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, APPW, APPH - 40)collectionViewLayout:self.customerLayout];
        [_collectionView registerNib:[UINib nibWithNibName:@"YMZCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
-(void)changeLayout:(UIButton *)bnt{
    if ([bnt.titleLabel.text isEqualToString:@"开始拖拽"]) {
        [bnt setTitle:@"结束拖拽" forState:UIControlStateNormal];
        self.collectionView.collectionViewLayout = self.flowLayout;
        [self.collectionView reloadData];
        [self.collectionView addGestureRecognizer:self.panGesture];
    }else{
        [bnt setTitle:@"开始拖拽" forState:UIControlStateNormal];
        self.collectionView.collectionViewLayout = self.customerLayout;
        [self.collectionView reloadData];
        [self.collectionView removeGestureRecognizer:self.panGesture];
        
    }
    //
    
    
}
@end
