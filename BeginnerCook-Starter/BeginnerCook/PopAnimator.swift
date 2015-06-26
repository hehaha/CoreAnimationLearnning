
//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by hexin on 15/5/28.
//  Copyright (c) 2015年 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let animationDuration = 1.0
    var presenting = true
    var originFrame = CGRectZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()
//        toView.alpha = 0
//        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
//            toView.alpha = 1
//        }) { _ in
//            transitionContext.completeTransition(true)
//        }
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let initalFrame = presenting ? originFrame : toView.frame
        let finalFrame = presenting ? toView.frame : originFrame
        let xScaleFactor = presenting ? initalFrame.width / finalFrame.width : finalFrame.width / initalFrame.width
        let yScaleFactor = presenting ? initalFrame.height / finalFrame.height : finalFrame.height / finalFrame.height
        let scale = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        if presenting {
            herbView.transform = scale
            herbView.center = CGPointMake(CGRectGetMidX(initalFrame), CGRectGetMidY(initalFrame))
            herbView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(herbView)
        UIView.animateWithDuration(animationDuration, delay:0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0,
            options: nil,
            animations: {
            herbView.transform = self.presenting ? CGAffineTransformIdentity : scale
            herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
            }, completion:{_ in
            transitionContext.completeTransition(true)
        })
    }
}
