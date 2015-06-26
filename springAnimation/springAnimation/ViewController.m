//
//  ViewController.m
//  springAnimation
//
//  Created by hexin on 15/4/22.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "ViewController.h"
#import "SpringView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SpringView *springView;
@property (nonatomic, strong)UIView *helpView;
@property(nonatomic, strong)UIPanGestureRecognizer *pan;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(caculateSpringOffset)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    self.helpView = [[UIView alloc]initWithFrame:CGRectMake(0, 300, 10, 10)];
    self.helpView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.helpView];
    [UIView animateWithDuration:3
                          delay:0
         usingSpringWithDamping:0.2
          initialSpringVelocity:10
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
        self.helpView.frame = CGRectMake(200, 300, 10, 10);
                     }
                     completion:^(BOOL finish){
                         [displayLink invalidate];
                     }];

//    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragging:)];
//    [self.view addGestureRecognizer:self.pan];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dragging:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.view];
    NSLog(@"%f", point.x);
    self.springView.offset = point.x;
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)caculateSpringOffset {
    CALayer *prensentLayer = (CALayer *)self.helpView.layer.presentationLayer;
    self.springView.offset = prensentLayer.frame.origin.x;
}
@end
