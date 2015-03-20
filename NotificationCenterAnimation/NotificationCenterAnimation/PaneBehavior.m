//
//  PaneBehavior.m
//  NotificationCenterAnimation
//
//  Created by hexin on 15/3/19.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "PaneBehavior.h"

@interface PaneBehavior ()
@property(nonatomic, strong)UIAttachmentBehavior *attach;
@property(nonatomic, strong)UIDynamicItemBehavior *itemBehavior;
@end

@implementation PaneBehavior

- (instancetype)initWithItem:(id<UIDynamicItem>)item
{
    self = [super init];
    if (self) {
        _attach = [[UIAttachmentBehavior alloc]initWithItem:item attachedToAnchor:CGPointZero];
        _attach.length = 0;
        _attach.damping = 1;
        _attach.frequency = 3.5;
        
        _itemBehavior = [[UIDynamicItemBehavior alloc]init];
        _itemBehavior.density = 100;
        _itemBehavior.resistance = 1;
        [_itemBehavior addItem:item];
        
        [self addChildBehavior:_attach];
        [self addChildBehavior:_itemBehavior];
    }
    return self;
}

-(void)setAnchorPoint:(CGPoint)anchorPoint
{
    self.attach.anchorPoint = anchorPoint;
}

- (void)addLinearVelocity:(CGPoint)velocity
{
    [self.itemBehavior addLinearVelocity:velocity forItem:self.attach.items.firstObject];
}
@end
