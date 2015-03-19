//
//  MyBehavior.m
//  UIDynamicAnimation
//
//  Created by hexin on 15/3/19.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "MyBehavior.h"

@interface MyBehavior ()
@property(nonatomic, strong)UICollisionBehavior *collision;
@property(nonatomic, strong)UIGravityBehavior *gravity;
@end

@implementation MyBehavior

- (UICollisionBehavior *)collision
{
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc]init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collision;
}

- (UIGravityBehavior *)gravity
{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc]init];
        _gravity.magnitude = 0.1;
    }
    return _gravity;
}
- (void)addItem:(id<UIDynamicItem>)item
{
    [self.collision addItem:item];
    [self.gravity addItem:item];
}

- (void)removeItem:(id<UIDynamicItem>)item
{
    [self.collision removeItem:item];
    [self.gravity removeItem:item];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildBehavior:self.collision];
        [self addChildBehavior:self.gravity];
    }
    return self;
}
@end
