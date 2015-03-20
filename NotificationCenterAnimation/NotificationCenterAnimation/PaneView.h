//
//  PaneView.h
//  NotificationCenterAnimation
//
//  Created by hexin on 15/3/19.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaneViewProtocol <NSObject>
- (void)paneViewDragAction:(UIPanGestureRecognizer *)sender;
@end

@interface PaneView : UIView
@property(nonatomic, weak)id delegate;
@end
