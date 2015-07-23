//
//  ViewController.m
//  soccerGame
//
//  Created by hexin on 15/6/27.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic, strong)UIImageView *ball;
@property (nonatomic, strong)UIImageView *door;
@property (nonatomic, strong)UICollisionBehavior *collisoionBehavior;
@property (nonatomic, strong)UIDynamicItemBehavior *itemBehavior;
@property (nonatomic, strong)UIDynamicAnimator *animator;
@property (nonatomic, assign)BOOL isAnimating;
@end

@implementation ViewController
static void *ballGestueBlock = "ballGestueBlock";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *fieldImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"soccer-field"]];
    fieldImageView.frame = self.view.bounds;
    [self.view addSubview:fieldImageView];
    
    UIImageView *doorImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"door"]];
    doorImageView.frame = CGRectMake(0, 0, 150, 40);
    doorImageView.center = CGPointMake(self.view.center.x, doorImageView.image.size.height / 2);
    [self.view addSubview:doorImageView];
    self.door = doorImageView;
    
    [self.animator addBehavior:self.collisoionBehavior];
    [self.animator addBehavior:self.itemBehavior];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(caculateIfGetGoal)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark event
- (void)ballDidPan: (UIPanGestureRecognizer *)pan {
    void (^handleBlock)(UIPanGestureRecognizer *pan) = objc_getAssociatedObject(self.ball, ballGestueBlock);
    handleBlock(pan);
}

- (void)caculateIfGetGoal {
    if (CGRectIntersectsRect(self.ball.frame, self.door.frame)) {
        [self.collisoionBehavior removeItem:self.ball];
        [self.itemBehavior removeItem:self.ball];
        [self animateGoalLabel];
    }
}

#pragma mark private method
- (void)animateGoalLabel {
    if (self.isAnimating == NO) {
        self.isAnimating = YES;
        UILabel *goalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        goalLabel.center = self.view.center;
        goalLabel.font = [UIFont systemFontOfSize:52];
        goalLabel.text = @"GOAL!";
        goalLabel.textAlignment = NSTextAlignmentCenter;
        goalLabel.textColor = [UIColor yellowColor];
        [self.view addSubview:goalLabel];
        goalLabel.transform = CGAffineTransformMakeScale(0, 0);
        self.view.userInteractionEnabled = NO;
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            goalLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [goalLabel removeFromSuperview];
            [UIView animateWithDuration:0.5 animations:^{
                self.ball.center = CGPointMake(self.view.center.x, 400);
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled = YES;
                self.isAnimating = NO;
            }];
        }];
    }
}

#pragma mark setter & getter
- (UIImageView *)ball {
    if (!_ball) {
        _ball = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"soccer-ball"]];
        _ball.userInteractionEnabled = YES;
        _ball.center = CGPointMake(self.view.center.x, 400);
        [self.view addSubview:_ball];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(ballDidPan:)];
        [_ball addGestureRecognizer:panGesture];
        __weak ViewController *weakSelf = self;
        void (^block)(UIPanGestureRecognizer *pan) = ^(UIPanGestureRecognizer *pan) {
            switch (pan.state) {
                case UIGestureRecognizerStateBegan:
                    [weakSelf.itemBehavior removeItem:weakSelf.ball];
                    [weakSelf.collisoionBehavior removeItem:weakSelf.ball];
                    break;
                case UIGestureRecognizerStateChanged:
                    weakSelf.ball.center = [pan locationInView:weakSelf.view];
                    break;
                case UIGestureRecognizerStateEnded:
                    [weakSelf.itemBehavior addItem:weakSelf.ball];
                    [weakSelf.collisoionBehavior addItem:weakSelf.ball];
                    [weakSelf.itemBehavior addLinearVelocity:[pan velocityInView:weakSelf.view] forItem:weakSelf.ball];
                    break;
                default:
                    break;
            }
        };
        objc_setAssociatedObject(_ball, ballGestueBlock, block, OBJC_ASSOCIATION_COPY);
    }
    return _ball;
}

- (UICollisionBehavior *)collisoionBehavior {
    if (!_collisoionBehavior) {
        _collisoionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.ball]];
        _collisoionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collisoionBehavior;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}

- (UIDynamicItemBehavior *)itemBehavior {
    if (!_itemBehavior) {
        _itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self.ball]];
        _itemBehavior.density = 0.5;
        _itemBehavior.resistance = 0.5;
        _itemBehavior.elasticity = 0.5;
    }
    return _itemBehavior;
}
@end
