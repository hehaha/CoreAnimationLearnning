//
//  PaneView.m
//  NotificationCenterAnimation
//
//  Created by hexin on 15/3/19.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "PaneView.h"

@interface PaneView ()
@property(nonatomic, strong)UIPanGestureRecognizer *pan;
@end

@implementation PaneView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.3;
        self.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-100, frame.size.width,frame.size.height * 2);
        self.layer.cornerRadius = self.frame.size.width/15;
    }
    return self;
}

- (UIPanGestureRecognizer *)pan
{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.delegate action:@selector(paneViewDragAction:)];
    }
    return _pan;
}

- (void)setDelegate:(id)delegate
{
    _delegate = delegate;
    
    [self addGestureRecognizer:self.pan];
}
@end
