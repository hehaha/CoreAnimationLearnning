//
//  ViewController.m
//  UIDynamicAnimation
//
//  Created by hexin on 15/3/19.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "ViewController.h"
#import "MyBehavior.h"

@interface ViewController ()
@property(nonatomic, strong)UIDynamicAnimator *animator;
@property(nonatomic, strong)UIAttachmentBehavior *attachBehavior;
@property(nonatomic, strong)UISnapBehavior *snap;
@property(nonatomic, strong)UIView* attachingView;
@property(nonatomic, strong)UIPanGestureRecognizer *panGesture;
@property(nonatomic, strong)MyBehavior *behavior;
@property(nonatomic, strong)UIDynamicItemBehavior *itemBehavior;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.attachingView = [[UIView alloc]init];
    self.attachingView.frame = CGRectMake(300, 300, 30, 30);
    self.attachingView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.attachingView];
    
    self.itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self.attachingView]];
    self.itemBehavior.elasticity = 0.75;
    
    self.snap = [[UISnapBehavior alloc]initWithItem:self.attachingView snapToPoint:CGPointMake(100, 100)];
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [self.animator addBehavior:self.itemBehavior];
    [self.animator addBehavior:self.behavior];
    
    [self.behavior addItem:self.attachingView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.animator addBehavior:self.snap];
}
- (MyBehavior *)behavior
{
    if (!_behavior) {
        _behavior = [[MyBehavior alloc]init];
    }
    return _behavior;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
