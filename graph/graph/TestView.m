//
//  TestView.m
//  graph
//
//  Created by hexin on 15/3/26.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* bC9F6E = [UIColor colorWithRed: 0.737 green: 0.624 blue: 0.431 alpha: 1];
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(123, 27, 60, 60)];
    [bC9F6E setFill];
    [oval2Path fill];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
//    [bezierPath moveToPoint: CGPointMake(167.77, 47.96)];
//    [bezierPath addCurveToPoint: CGPointMake(152.75, 37) controlPoint1: CGPointMake(165.8, 41.62) controlPoint2: CGPointMake(159.82, 37)];
//    [bezierPath addCurveToPoint: CGPointMake(146.83, 38.14) controlPoint1: CGPointMake(150.65, 37) controlPoint2: CGPointMake(148.66, 37.4)];
//    [bezierPath addCurveToPoint: CGPointMake(137.93, 47.35) controlPoint1: CGPointMake(142.69, 39.81) controlPoint2: CGPointMake(139.42, 43.17)];
    [bezierPath moveToPoint: CGPointMake(168, 56.26)];
    [bezierPath addCurveToPoint: CGPointMake(165.46, 61.65) controlPoint1: CGPointMake(167.51, 58.23) controlPoint2: CGPointMake(166.63, 60.05)];
    [bezierPath addCurveToPoint: CGPointMake(152.75, 79) controlPoint1: CGPointMake(165.61, 61.65) controlPoint2: CGPointMake(152.75, 79)];
    [bezierPath addCurveToPoint: CGPointMake(139.72, 61.2) controlPoint1: CGPointMake(152.75, 79) controlPoint2: CGPointMake(139.48, 61.2)];
    [bezierPath addCurveToPoint: CGPointMake(137.48, 56.2) controlPoint1: CGPointMake(138.69, 59.7) controlPoint2: CGPointMake(137.93, 58.01)];
    bezierPath.lineCapStyle = kCGLineCapRound;
    
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    
    [UIColor.whiteColor setStroke];
    bezierPath.lineWidth = 2.5;
    [bezierPath stroke];
    
    
    //// Oval 3 Drawing
    UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(216, 28, 60, 60)];
    [bC9F6E setFill];
    [oval3Path fill];
    
    
    //// center step Drawing
    UIBezierPath* centerStepPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(233, 51, 26, 10) cornerRadius: 5];
    [UIColor.whiteColor setFill];
    [centerStepPath fill];
    
    
    //// Group
    {
        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
        [bezier3Path moveToPoint: CGPointMake(260.29, 65.1)];
        [bezier3Path addCurveToPoint: CGPointMake(245.53, 78) controlPoint1: CGPointMake(260.42, 65.1) controlPoint2: CGPointMake(245.53, 78)];
        [bezier3Path addCurveToPoint: CGPointMake(230.78, 65.1) controlPoint1: CGPointMake(245.53, 78) controlPoint2: CGPointMake(230.56, 65.09)];
        bezier3Path.lineCapStyle = kCGLineCapRound;
        
        bezier3Path.lineJoinStyle = kCGLineJoinRound;
        
        [UIColor.whiteColor setStroke];
        bezier3Path.lineWidth = 3;
        [bezier3Path stroke];
        
        
        //// Oval 4 Drawing
        UIBezierPath* oval4Path = UIBezierPath.bezierPath;
        [oval4Path moveToPoint: CGPointMake(261.58, 44.68)];
        [oval4Path addCurveToPoint: CGPointMake(245.53, 40.5) controlPoint1: CGPointMake(256.85, 42.02) controlPoint2: CGPointMake(251.37, 40.5)];
        [oval4Path addCurveToPoint: CGPointMake(229.78, 44.52) controlPoint1: CGPointMake(239.81, 40.5) controlPoint2: CGPointMake(234.44, 41.96)];
        oval4Path.lineCapStyle = kCGLineCapRound;
        
        [color setStroke];
        oval4Path.lineWidth = 3;
        [oval4Path stroke];
    }
    
    
    //// Oval 5 Drawing
    UIBezierPath* oval5Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(309, 28, 60, 60)];
    [bC9F6E setFill];
    [oval5Path fill];
    
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = UIBezierPath.bezierPath;
    [bezier4Path moveToPoint: CGPointMake(356.5, 46.5)];
    [bezier4Path addLineToPoint: CGPointMake(320.5, 46.5)];
    [bezier4Path addLineToPoint: CGPointMake(356.5, 46.5)];
    [bezier4Path closePath];
    bezier4Path.lineCapStyle = kCGLineCapRound;
    
    bezier4Path.lineJoinStyle = kCGLineJoinRound;
    
    [color setStroke];
    bezier4Path.lineWidth = 4;
    [bezier4Path stroke];
    
    
    //// center step 2 Drawing
    UIBezierPath* centerStep2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(326, 58, 26, 6) cornerRadius: 3];
    [UIColor.whiteColor setFill];
    [centerStep2Path fill];
    
    
    //// Bezier 5 Drawing
    UIBezierPath* bezier5Path = UIBezierPath.bezierPath;
    [bezier5Path moveToPoint: CGPointMake(344.5, 76)];
    [bezier5Path addLineToPoint: CGPointMake(332.5, 76)];
    [bezier5Path addLineToPoint: CGPointMake(344.5, 76)];
    [bezier5Path closePath];
    bezier5Path.lineCapStyle = kCGLineCapRound;
    
    bezier5Path.lineJoinStyle = kCGLineJoinRound;
    
    [color setStroke];
    bezier5Path.lineWidth = 4;
    [bezier5Path stroke];
    
    
    //// Oval 6 Drawing
    UIBezierPath* oval6Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(400.5, 30, 60, 60)];
    [bC9F6E setFill];
    [oval6Path fill];
    
    
    //// Bezier 6 Drawing
    UIBezierPath* bezier6Path = UIBezierPath.bezierPath;
    [bezier6Path moveToPoint: CGPointMake(431, 74)];
    [bezier6Path addLineToPoint: CGPointMake(415, 74)];
    [bezier6Path addLineToPoint: CGPointMake(431, 74)];
    [bezier6Path closePath];
    bezier6Path.lineCapStyle = kCGLineCapRound;
    
    bezier6Path.lineJoinStyle = kCGLineJoinRound;
    
    [color setStroke];
    bezier6Path.lineWidth = 5;
    [bezier6Path stroke];
    
    
    //// Bezier 7 Drawing
    UIBezierPath* bezier7Path = UIBezierPath.bezierPath;
    [bezier7Path moveToPoint: CGPointMake(447, 48.5)];
    [bezier7Path addLineToPoint: CGPointMake(415, 48.5)];
    [bezier7Path addLineToPoint: CGPointMake(447, 48.5)];
    [bezier7Path closePath];
    bezier7Path.lineCapStyle = kCGLineCapRound;
    
    bezier7Path.lineJoinStyle = kCGLineJoinRound;
    
    [color setStroke];
    bezier7Path.lineWidth = 5;
    [bezier7Path stroke];
    
    
    // Bezier 8 Drawing
    UIBezierPath* bezier8Path = UIBezierPath.bezierPath;
    [bezier8Path moveToPoint: CGPointMake(439, 60.5)];
    [bezier8Path addLineToPoint: CGPointMake(415, 61)];
    [bezier8Path addLineToPoint: CGPointMake(439, 60.5)];
    [bezier8Path closePath];
    bezier8Path.lineCapStyle = kCGLineCapRound;
    
    bezier8Path.lineJoinStyle = kCGLineJoinRound;
    
    [color setStroke];
    bezier8Path.lineWidth = 5;
    [bezier8Path stroke];
}

@end
