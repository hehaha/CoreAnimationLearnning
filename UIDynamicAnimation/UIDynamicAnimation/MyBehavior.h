//
//  MyBehavior.h
//  UIDynamicAnimation
//
//  Created by hexin on 15/3/19.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBehavior : UIDynamicBehavior
- (void)addItem:(id<UIDynamicItem>)item;
- (void)removeItem:(id<UIDynamicItem>)item;
@end
