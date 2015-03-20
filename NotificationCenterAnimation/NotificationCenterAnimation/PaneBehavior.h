//
//  PaneBehavior.h
//  NotificationCenterAnimation
//
//  Created by hexin on 15/3/19.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaneBehavior : UIDynamicBehavior
- (instancetype)initWithItem:(id<UIDynamicItem>)item;
- (void)setAnchorPoint:(CGPoint)anchorPoint;
- (void)addLinearVelocity:(CGPoint)velocity;
@end
