//
//  ViewController.m
//  3DAnimation
//
//  Created by hexin on 15/3/18.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *view1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = [[UIScreen mainScreen]bounds];
    CGPoint center = CGPointMake(rect.size.width/2 ,rect.size.height/2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle:0 endAngle:M_PI clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4;
    
    CAShapeLayer *another = [CAShapeLayer layer];
    another.path = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle:M_PI endAngle:0 clockwise:YES].CGPath;
    another.strokeColor = [UIColor redColor].CGColor;
    another.fillColor = [UIColor clearColor].CGColor;
    another.lineWidth = 4;
    
    [self.view.layer addSublayer:shapeLayer];
    [self.view.layer addSublayer:another];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.duration = 1;
    animation.fillMode = kCAFillModeBackwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *animation2 = [animation copy];
    animation2.beginTime = CACurrentMediaTime() + 1.1;
    
    [shapeLayer addAnimation:animation forKey:nil];
    [another addAnimation:animation2 forKey:nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:(id)[UIColor redColor].CGColor];
    [array addObject:(id)[UIColor yellowColor].CGColor];
    [array addObject:(id)[UIColor blueColor].CGColor];
    gradientLayer.colors = array;
    gradientLayer.frame = CGRectMake(0, 100, 300, 10);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    [self.view.layer addSublayer:gradientLayer];
    
    NSMutableArray *array1 = [NSMutableArray array];
    [array1 addObject:(id)[UIColor blueColor].CGColor];
    [array1 addObject:(id)[UIColor redColor].CGColor];
    [array1 addObject:(id)[UIColor yellowColor].CGColor];
    
    CABasicAnimation *animatiom = [CABasicAnimation animationWithKeyPath:@"colors"];
    animatiom.fromValue = array;
    animatiom.duration = 2.1;
    
    gradientLayer.colors = array1;
    [gradientLayer addAnimation:animatiom forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
