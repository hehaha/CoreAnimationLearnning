//
//  SpringView.m
//  UIDynamicAnimation
//
//  Created by hexin on 15/4/22.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "SpringView.h"

@interface SpringView()
@property(nonatomic, assign)CGFloat controlPointX;
@property(nonatomic, assign)BOOL reverse;
@end

@implementation SpringView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _reverse = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor redColor]set];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddLineToPoint(path, nil, 200, 0);
    CGPathAddQuadCurveToPoint(path, nil, self.offset, 100, 200, 200);
    CGPathAddLineToPoint(path, nil, 0, 200);
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
}

- (void)setOffset:(CGFloat)offset {
    _offset = offset - 438;

    self.reverse = !self.reverse;
    
    [self setNeedsDisplay];
}
@end
