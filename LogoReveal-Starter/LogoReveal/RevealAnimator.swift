//
//  RevealAnimator.swift
//  LogoReveal
//
//  Created by hexin on 15/5/19.
//  Copyright (c) 2015年 Razeware LLC. All rights reserved.
//

import UIKit

class RevealAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    let animationDuration: NSTimeInterval = 2.0
    
    var operation: UINavigationControllerOperation = .Push
    
    var interactive = false
    
    weak var storeContext: UIViewControllerContextTransitioning?
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if operation == .Push {
            storeContext = transitionContext
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! MasterViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DetailViewController
            transitionContext.containerView().addSubview(toVC.view)
            
            let animation = CABasicAnimation(keyPath: "transform")
            animation.delegate = self
            animation.duration = animationDuration
            animation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
            animation.toValue = NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeTranslation(0, -10, 0),CATransform3DMakeScale(150, 150, 1)))
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            toVC.maskLayer.addAnimation(animation, forKey: nil)
            fromVC.logo.addAnimation(animation, forKey: nil)
            
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.duration = animationDuration
            opacityAnimation.fromValue = 0
            opacityAnimation.toValue = 1
            opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            
            toVC.view.layer.addAnimation(opacityAnimation, forKey: nil)
        }
        else {
            storeContext = transitionContext
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            transitionContext.containerView().insertSubview(toView!, belowSubview: fromView!)
            
            let scaleAnimation = CABasicAnimation(keyPath: "transform")
            scaleAnimation.duration = animationDuration
            scaleAnimation.delegate = self
            scaleAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
            scaleAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(0.01, 0.01, 1))
            scaleAnimation.removedOnCompletion = false
            scaleAnimation.fillMode = kCAFillModeForwards
            scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            fromView!.layer.addAnimation(scaleAnimation, forKey: nil)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return animationDuration
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if let context = storeContext {
            context.completeTransition(!context.transitionWasCancelled())
            if let fromVC = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as? MasterViewController {
                fromVC.logo.removeAllAnimations()
            }
        }
        storeContext = nil
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        let transition = recognizer.translationInView(recognizer.view!)
        var process: CGFloat = abs(transition.x / 200)
        process = max(min(process, 0.99), 0.01)
        
        switch recognizer.state {
        case .Changed:
            updateInteractiveTransition(process)
        case .Cancelled, .Ended:
            let transitionLayer = storeContext!.containerView().layer
            transitionLayer.beginTime = CACurrentMediaTime()
            if process < 0.5 {
                completionSpeed = -1
                cancelInteractiveTransition()
            }
            else {
               completionSpeed = 1
                finishInteractiveTransition()
            }
            interactive = false
        default:
            break
        }
        
    }
}
