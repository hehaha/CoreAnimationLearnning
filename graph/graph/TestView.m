//
//  TestView.m
//  graph
//
//  Created by hexin on 15/3/26.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 100);
    CGFloat y;
    for (CGFloat i = 0; i<500; i = i + 0.1) {
        y = sin(i/20)*20;
        CGPathAddLineToPoint(path, nil, i, 100+y);
    }
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
}
@end
