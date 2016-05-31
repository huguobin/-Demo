//
//  ViewController.m
//  桌面拖动分组Demo
//
//  Created by huGb on 16/5/30.
//  Copyright © 2016年 iyd. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "MycollectionView.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,retain)NSMutableArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    _collectionView = [[MycollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    _collectionView.backgroundColor = [UIColor cyanColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.remembersLastFocusedIndexPath=YES;
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"myCell"];
    //此处给其增加长按手势，用此手势触发cell移动效果
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    [_collectionView addGestureRecognizer:longGesture];
    [self.view addSubview:_collectionView];
    _dataSource = [NSMutableArray array];
    for (int i = 1; i <= 50; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d",i];
        [_dataSource addObject:imageName];
    }
}


- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}


- (BOOL)beginInteractiveMovementForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
     NSLog(@"indexPath:%ld",(long)indexPath.row);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    
    NSLog(@"sourceIndexPath:%ld--destinationIndexPath:%ld",(long)sourceIndexPath.item,(long)destinationIndexPath.row);
    
    //取出源item数据
    id objc = [_dataSource objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [_dataSource removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [_dataSource insertObject:objc atIndex:destinationIndexPath.item];
    
//    [self.collectionView performBatchUpdates:^{
//        
//       // self.collectionView
//    } completion:^(BOOL finished) {
//        
//    }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.name.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
