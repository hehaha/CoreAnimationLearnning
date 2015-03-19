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
@property(nonatomic, strong)UIView *myView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.attachingView = [[UIView alloc]init];
    self.attachingView.frame = CGRectMake(300, 300, 30, 30);
    self.attachingView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.attachingView];
    
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pannedAction:)];
    [self.view addGestureRecognizer:self.panGesture];
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [self.animator addBehavior:self.behavior];
    
    UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    newView.backgroundColor = [UIColor redColor];
    [self.view addSubview:newView];
    [self.behavior addItem:self.attachingView];
    [self.behavior addItem:newView];
    self.myView = newView;
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

- (void)pannedAction:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.attachBehavior = [[UIAttachmentBehavior alloc]initWithItem:self.attachingView attachedToAnchor:[sender locationInView:self.view]];
        [self.animator addBehavior:self.attachBehavior];
        [self.animator removeBehavior:self.snap];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        self.attachBehavior.anchorPoint = [sender locationInView:self.view];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:self.attachBehavior];
        self.snap = [[UISnapBehavior alloc]initWithItem:self.attachingView snapToPoint:self.myView.center];
        [self.animator addBehavior: self.snap];
    }
}
@end
