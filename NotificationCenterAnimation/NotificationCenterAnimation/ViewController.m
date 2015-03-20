//
//  ViewController.m
//  NotificationCenterAnimation
//
//  Created by hexin on 15/3/19.
//  Copyright (c) 2015年 hexin. All rights reserved.
//

#import "ViewController.h"
#import "PaneView.h"
#import "PaneBehavior.h"

@interface ViewController ()<PaneViewProtocol>
@property(nonatomic, strong)UIDynamicAnimator *animatior;
@property(nonatomic, strong)PaneBehavior *behavior;
@property(nonatomic, strong)PaneView* notificationView;
@property(nonatomic, assign)CGPoint topTargetPoint;
@property(nonatomic, assign)CGPoint bottomTargetPoint;
@end

@implementation ViewController
const CGFloat offset = 100;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.notificationView = [[PaneView alloc]initWithFrame:self.view.bounds];
    self.notificationView.delegate = self;
    [self.view addSubview:self.notificationView];
    
    self.animatior = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)paneViewDragAction:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender translationInView:self.view];
    self.notificationView.center = CGPointMake(self.notificationView.center.x, self.notificationView.center.y + point.y);
    [sender setTranslation:CGPointZero inView:self.view];
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.animatior removeAllBehaviors];
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocity = [sender velocityInView:self.view];
        CGPoint targrtVelocity = CGPointMake(0, velocity.y);
        self.behavior = [[PaneBehavior alloc]initWithItem:self.notificationView];
        [self.animatior addBehavior:self.behavior];
        if (velocity.y > 0) {
            [self.behavior setAnchorPoint:self.bottomTargetPoint];
        }
        else {
            [self.behavior setAnchorPoint:self.topTargetPoint];
        }
        [self.behavior addLinearVelocity:targrtVelocity];
    }
}

- (CGPoint)topTargetPoint
{
    CGRect screenFrame = self.view.bounds;
    return CGPointMake( screenFrame.size.width/2,self.notificationView.frame.size.height/2 + offset );
}

- (CGPoint)bottomTargetPoint
{
    CGRect screenFrame = self.view.bounds;
    return CGPointMake( screenFrame.size.width/2,self.notificationView.frame.size.height/2 + screenFrame.size.height - offset );
}
@end
