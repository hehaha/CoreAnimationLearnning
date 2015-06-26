//
//  ViewController.m
//  graph
//
//  Created by hexin on 15/3/26.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CAShapeLayer* shapeLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    shapeLayer = [[CAShapeLayer alloc] init];
    
    CGRect bounds = self.view.bounds;
    bounds.origin.x += 0.25 * bounds.size.width;
    bounds.size.width *= 0.5;
    bounds.origin.y += 0.25 * bounds.size.height;
    bounds.size.height *= 0.5;
    
    shapeLayer.frame = bounds;
    shapeLayer.backgroundColor = [[UIColor redColor] CGColor];
    
    [self.view.layer addSublayer: shapeLayer];
    [self toCircle: nil];
}

CGPoint AveragePoints(CGPoint a, CGPoint b)
{
    return CGPointMake((a.x + b.x) * 0.5f, (a.y + b.y) * 0.5f);
}

- (IBAction)toCircle:(id)sender
{
    UIBezierPath* p = [[UIBezierPath alloc] init];
    
    [p moveToPoint: CGPointMake(80, 56)];
    [p addCurveToPoint:CGPointMake(144, 120) controlPoint1:CGPointMake(115.34622, 56) controlPoint2:CGPointMake(144, 84.653778)];
    [p addCurveToPoint:CGPointMake(135.42563, 152) controlPoint1:CGPointMake(144, 131.23434) controlPoint2:CGPointMake(141.0428, 142.27077)];
    [p addCurveToPoint:CGPointMake(48, 175.42563) controlPoint1:CGPointMake(117.75252, 182.61073) controlPoint2:CGPointMake(78.610725, 193.09874)];
    [p addCurveToPoint:CGPointMake(24.574375, 152) controlPoint1:CGPointMake(38.270771, 169.80846) controlPoint2:CGPointMake(30.191547, 161.72923)];
    [p addCurveToPoint:CGPointMake(47.999996, 64.574379) controlPoint1:CGPointMake(6.9012618, 121.38927) controlPoint2:CGPointMake(17.389269, 82.24749)];
    [p addCurveToPoint:CGPointMake(80, 56) controlPoint1:CGPointMake(57.729225, 58.957207) controlPoint2:CGPointMake(68.765656, 56)];
    [p closePath];
    
    [CATransaction begin];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 3.f;
    pathAnimation.fromValue = (id)shapeLayer.path;
    pathAnimation.toValue = (id)p.CGPath;
    [shapeLayer addAnimation:pathAnimation forKey:@"path"];
    [CATransaction setCompletionBlock:^{
        shapeLayer.path = p.CGPath;
    }];
    [CATransaction commit];
    
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self toTriangle: nil];
    });
    
}

- (IBAction)toTriangle: (id)sender
{
    UIBezierPath* p = [[UIBezierPath alloc] init];
    
    // Triangle using the same number and kind of points...
    [p moveToPoint: CGPointMake(80, 56)];
    [p addCurveToPoint: AveragePoints(CGPointMake(80, 56), CGPointMake(135.42563, 152))  controlPoint1:CGPointMake(80, 56) controlPoint2:AveragePoints(CGPointMake(80, 56), CGPointMake(135.42563, 152))];
    [p addCurveToPoint:CGPointMake(135.42563, 152) controlPoint1:AveragePoints(CGPointMake(80, 56), CGPointMake(135.42563, 152)) controlPoint2:CGPointMake(135.42563, 152)];
    [p addCurveToPoint:AveragePoints(CGPointMake(135.42563, 152), CGPointMake(24.574375, 152)) controlPoint1:CGPointMake(135.42563, 152) controlPoint2:AveragePoints(CGPointMake(135.42563, 152), CGPointMake(24.574375, 152))];
    [p addCurveToPoint:CGPointMake(24.574375, 152) controlPoint1:AveragePoints(CGPointMake(135.42563, 152), CGPointMake(24.574375, 152)) controlPoint2:CGPointMake(24.574375, 152)];
    [p addCurveToPoint: AveragePoints(CGPointMake(24.574375, 152),CGPointMake(80, 56)) controlPoint1:CGPointMake(24.574375, 152) controlPoint2:AveragePoints(CGPointMake(24.574375, 152),CGPointMake(80, 56)) ];
    [p addCurveToPoint:CGPointMake(80, 56) controlPoint1:AveragePoints(CGPointMake(24.574375, 152),CGPointMake(80, 56)) controlPoint2:CGPointMake(80, 56)];
    [p closePath];
    
    [CATransaction begin];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 3.f;
    pathAnimation.fromValue = (id)shapeLayer.path;
    pathAnimation.toValue = (id)p.CGPath;
    [shapeLayer addAnimation:pathAnimation forKey:@"path"];
    [CATransaction setCompletionBlock:^{
        shapeLayer.path = p.CGPath;
    }];
    [CATransaction commit];
    
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self toCircle: nil];
    });
    
}

@end
