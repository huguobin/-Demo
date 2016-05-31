//
//  MycollectionView.m
//  桌面拖动分组Demo
//
//  Created by huGb on 16/5/30.
//  Copyright © 2016年 iyd. All rights reserved.
//

#import "MycollectionView.h"

@implementation MycollectionView

- (BOOL)beginInteractiveMovementForItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
{

    BOOL CanMove = [super beginInteractiveMovementForItemAtIndexPath:indexPath];
    return CanMove;
    
}// returns NO if reordering was prevented from beginning - otherwise YES
- (void)updateInteractiveMovementTargetPosition:(CGPoint)targetPosition NS_AVAILABLE_IOS(9_0)
{
    [super updateInteractiveMovementTargetPosition:targetPosition];
    
}
- (void)endInteractiveMovement NS_AVAILABLE_IOS(9_0)
{
    [super endInteractiveMovement];
    
}

- (void)cancelInteractiveMovement NS_AVAILABLE_IOS(9_0)
{
    [super cancelInteractiveMovement];
    
}

@end
