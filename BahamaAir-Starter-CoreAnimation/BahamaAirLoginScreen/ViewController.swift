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

// A delay function
func delay(#seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController {
    
    // MARK: IB outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var heading: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let info = UILabel()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    var statusPosition = CGPoint.zeroPoint
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.hidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .Center
        status.addSubview(label)
        
        statusPosition = status.center
        
        info.frame = CGRectMake(0, loginButton.center.y + 60, view.frame.width, 30)
        info.backgroundColor = UIColor.clearColor()
        info.font = UIFont(name: "HelveticaNeue", size: 12)
        info.textAlignment = .Center
        info.textColor = UIColor.whiteColor()
        info.text = "Tap on a field and enter username and password"
        view.insertSubview(info, aboveSubview: loginButton)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let flightRight = CABasicAnimation(keyPath: "position.x")
        flightRight.duration = 0.5
        flightRight.toValue = view.bounds.width/2
        flightRight.fillMode = kCAFillModeBoth
        
        heading.layer.addAnimation(flightRight, forKey: nil)
        
        flightRight.beginTime = CACurrentMediaTime() + 0.3
        username.layer.addAnimation(flightRight, forKey: nil)
        
        flightRight.beginTime = CACurrentMediaTime() + 0.4
        password.layer.addAnimation(flightRight, forKey: nil)
        
        let cloudFade = CABasicAnimation(keyPath: "opacity")
        cloudFade.duration = 0.5
        cloudFade.fromValue = 0
        cloudFade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        cloud1.layer.addAnimation(cloudFade, forKey: nil)
        cloud2.layer.addAnimation(cloudFade, forKey: nil)
        cloud3.layer.addAnimation(cloudFade, forKey: nil)
        cloud4.layer.addAnimation(cloudFade, forKey: nil)
        
        let infoLeft = CABasicAnimation(keyPath: "position.x")
        infoLeft.duration = 5.0
        infoLeft.fromValue = info.layer.position.x + view.bounds.width
        info.layer.addAnimation(infoLeft, forKey: "infoAppear")
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: nil, animations: {
            self.loginButton.center.y -= 30.0
            self.loginButton.alpha = 1.0
            }, completion: nil)
        
        animateCloud(cloud1)
        animateCloud(cloud2)
        animateCloud(cloud3)
        animateCloud(cloud4)
    }
    
    // MARK: further methods
    
    @IBAction func login() {
        
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: nil, animations: {
            self.loginButton.bounds.size.width += 80.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: nil, animations: {
            self.loginButton.center.y += 60.0
            self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height/2)
            self.spinner.alpha = 1.0
            
            }, completion: {_ in
                self.showMessage(index: 0)
        })
        
        let originColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1)
        tintBackgroundColor(layer: loginButton.layer, color: originColor)
        roundCorner(layer: loginButton.layer, toRadius: 25)
    }
    
    func showMessage(#index: Int) {
        label.text = messages[index]
        
        UIView.transitionWithView(status, duration: 0.33, options:
            .CurveEaseOut | .TransitionFlipFromBottom, animations: {
                self.status.hidden = false
            }, completion: {_ in
                //transition completion
                delay(seconds: 2.0) {
                    if index < self.messages.count-1 {
                        self.removeMessage(index: index)
                    } else {
                        //reset form
                        self.resetForm()
                    }
                }
        })
    }
    
    func removeMessage(#index: Int) {
        UIView.animateWithDuration(0.33, delay: 0.0, options: nil, animations: {
            self.status.center.x += self.view.frame.size.width
            }, completion: {_ in
                self.status.hidden = true
                self.status.center = self.statusPosition
                
                self.showMessage(index: index+1)
        })
    }
    
    func resetForm() {
        UIView.transitionWithView(status, duration: 0.2, options: .TransitionFlipFromTop, animations: {
            self.status.hidden = true
            self.status.center = self.statusPosition
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: nil, animations: {
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0.0
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
            }, completion: nil)
        self.tintBackgroundColor(layer: self.loginButton.layer, color: UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1))
        self.roundCorner(layer: self.loginButton.layer, toRadius: 10)
    }
    
    func animateCloud(cloud: UIImageView) {
        let cloudSpeed = 60.0 / view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        UIView.animateWithDuration(NSTimeInterval(duration), delay: 0.0, options: .CurveLinear, animations: {
            cloud.frame.origin.x = self.view.frame.size.width
            }, completion: {_ in
                cloud.frame.origin.x = -cloud.frame.size.width
                self.animateCloud(cloud)
        })
    }
    
    func tintBackgroundColor(#layer: CALayer, color: UIColor) {
        let animatedBackgroundColor = CABasicAnimation(keyPath: "backgroundColor")
        animatedBackgroundColor.duration = 1
        animatedBackgroundColor.fromValue = layer.backgroundColor
        layer.addAnimation(animatedBackgroundColor, forKey: nil)
        
        layer.backgroundColor = color.CGColor
    }
    
    func roundCorner(#layer: CALayer, toRadius: CGFloat) {
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.duration = 0.5
        round.fromValue = layer.cornerRadius
        layer.addAnimation(round, forKey: nil)
        
        layer.cornerRadius = toRadius
    }
}