/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController, POPAnimationDelegate {
    
    @IBOutlet var goal: UIImageView!
    @IBOutlet var ball: UIImageView!
    weak var animatingLabel: UILabel?
    
    var playingRect: CGRect!
    var observeBounds = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup ball interaction
        ball.userInteractionEnabled = true
        ball.addGestureRecognizer(
            UIPanGestureRecognizer(target: self, action: Selector("didPan:"))
        )
        
        let tap = UITapGestureRecognizer(target: self, action: "didTap:")
        view.addGestureRecognizer(tap)
        resetBall()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        ball.alpha = 0
        
        fadeIn(ball)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLabel("Come On!")
    }
    
    func didPan(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .Began:
            ball.pop_removeAllAnimations()
            animatingLabel?.pop_removeAllAnimations()
            animatingLabel?.removeFromSuperview()
        case .Changed:
            ball.center = pan.locationInView(view)
        case .Ended:
            let velocity = pan.velocityInView(view)
            let decay = POPDecayAnimation(propertyNamed: kPOPViewCenter)
            decay.fromValue = NSValue(CGPoint: ball.center)
            decay.deceleration = 0.995
            decay.velocity = NSValue(CGPoint: velocity)
            decay.delegate = self
            
            ball.pop_addAnimation(decay, forKey: nil)
        default:
            break
        }
    }
    
    func pop_animationDidStop(anim: POPAnimation!, finished: Bool) {
        if finished {
            resetBall()
            fadeIn(ball)
        }
    }
    
    func pop_animationDidApply(anim: POPAnimation!) {
        if goal.frame.contains(ball.center) {
            ball.pop_removeAllAnimations()
            animateLabel("GOAL!")
            resetBall()
            return
        }
        if let decay = anim as? POPDecayAnimation {
            if let velocityValue = decay.velocity as? NSValue {
                let velocity = velocityValue.CGPointValue()
                if ball.frame.origin.x < 0 || ball.frame.origin.x > view.frame.width {
                    let newVelocity = CGPointMake(-velocity.x, velocity.y)
                    decay.velocity = NSValue(CGPoint: newVelocity)
                }
                else if ball.frame.origin.y < 0 || ball.frame.origin.y > view.frame.height {
                    let newVelocity = CGPointMake(velocity.x, -velocity.y)
                    decay.velocity = NSValue(CGPoint: newVelocity)
                }
            }
        }
    }
    
    func resetBall() {
        //set ball at random position on the field
        let randomX = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        ball.center = CGPoint(x: randomX * view.frame.size.width, y: view.frame.size.height * 0.7)
    }
    
    func fadeIn(view: UIView) {
        let fade = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        fade.fromValue = 0
        fade.toValue = 1
        fade.duration = 1
        view.pop_addAnimation(fade, forKey: nil)
    }
    
    func animateLabel(text: String) {
        let offscreenFrame = CGRectMake(0, 0, view.frame.width, 50)
        let label = UILabel(frame: offscreenFrame)
        label.center = view.center
        label.font = UIFont(name: "ArialRoundedMTBold", size: 52)
        label.textAlignment = .Center
        label.textColor = UIColor.yellowColor()
        label.text = text
        label.shadowColor = UIColor.darkGrayColor()
        label.shadowOffset = CGSizeMake(2, 2)
        view.addSubview(label)
        
        let spring = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        spring.fromValue = NSValue(CGPoint: CGPointZero)
        spring.toValue = NSValue(CGPoint: CGPointMake(1, 1))
        spring.springBounciness = 20
        spring.springSpeed = 1
        
        label.pop_addAnimation(spring, forKey: "spring")
        spring.completionBlock = { animation, finish in
            let fadeOut = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            fadeOut.toValue = 0.25
            fadeOut.duration = 0.5
            fadeOut.completionBlock = {_, _ in
                label.removeFromSuperview()
            }
            label.pop_addAnimation(fadeOut, forKey: nil)
        }
        animatingLabel = label
    }
    
    func didTap(tap: UITapGestureRecognizer) {
        if let spring = animatingLabel?.pop_animationForKey("spring") as? POPSpringAnimation {
            spring.toValue = NSValue(CGPoint: tap.locationInView(view))
        }
    }
}