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
import QuartzCore

//
// Util delay function
//

enum AnimationDirection: Int {
    case Forward = 1
    case Backward = -1
}

func delay(#seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var bgImageView: UIImageView!
    
    @IBOutlet var summaryIcon: UIImageView!
    @IBOutlet var summary: UILabel!
    
    @IBOutlet var flightNr: UILabel!
    @IBOutlet var gateNr: UILabel!
    @IBOutlet var departingFrom: UILabel!
    @IBOutlet var arrivingTo: UILabel!
    @IBOutlet var planeImage: UIImageView!
    
    @IBOutlet var flightStatus: UILabel!
    @IBOutlet var statusBanner: UIImageView!
    
    var snowView: SnowView!
    
    //MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjust ui
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height/2
        
        //add the snow effect layer
        snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
        let snowClipView = UIView(frame: CGRectOffset(view.frame, 0, 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        //start rotating the flights
        changeFlightDataTo(londonToParis, animated: true)
    }
    
    //MARK: custom methods
    
    func changeFlightDataTo(data: FlightData, animated: Bool) {
        // populate the UI with the next flight's data
        summary.text = data.summary
        let showImage = UIImage(named: data.weatherImageName)!
        if animated {
            shakeTransition(label: departingFrom, text: data.departingFrom, offset: CGPointMake(0, -5))
            shakeTransition(label: arrivingTo, text: data.arrivingTo, offset: CGPointMake(0, 5))
            cubeTransition(label: flightNr, text: data.flightNr, direction: data.isTakingOff ? .Forward : .Backward)
            cubeTransition(label: gateNr, text: data.gateNr, direction: data.isTakingOff ? .Forward : .Backward)
            cubeTransition(label: flightStatus, text: data.flightStatus, direction: data.isTakingOff ? .Forward : .Backward)
            fadeImageView(bgImageView, toImage: showImage, showEffects: data.showWeatherEffects)
            departPlane()
        }
        else {
            departingFrom.text = data.departingFrom
            arrivingTo.text = data.arrivingTo
            flightNr.text = data.flightNr
            gateNr.text = data.gateNr
            flightStatus.text = data.flightStatus
            bgImageView.image = showImage
            snowView.hidden = !data.showWeatherEffects
        }
        
        // schedule next flight
        delay(seconds: 3.0) {
            self.changeFlightDataTo(data.isTakingOff ? parisToRome : londonToParis, animated: true)
        }
    }
    
    func fadeImageView(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
        UIView.transitionWithView(imageView, duration: 0.5, options: .TransitionCrossDissolve, animations: { () -> Void in
            imageView.image = toImage
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            self.snowView.hidden = !showEffects
        }, completion: nil)
        
    }
    
    func cubeTransition(#label: UILabel, text: String, direction: AnimationDirection) {
        let tempLabel = UILabel(frame: label.frame)
        tempLabel.text = text
        tempLabel.textAlignment = label.textAlignment
        tempLabel.font = label.font
        tempLabel.backgroundColor = label.backgroundColor
        tempLabel.textColor = label.textColor
        label.superview?.addSubview(tempLabel)
        
        let labelOffset = CGFloat(direction.rawValue) * label.frame.height / 2
        tempLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.1),
            CGAffineTransformMakeTranslation(0, labelOffset))
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tempLabel.transform = CGAffineTransformIdentity
            label.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.1),
                CGAffineTransformMakeTranslation(0, -labelOffset))
        }) { (finish) -> Void in
            label.text = text
            tempLabel.removeFromSuperview()
            label.transform = CGAffineTransformIdentity
        }
    }
    
    func shakeTransition(#label: UILabel, text: String, offset: CGPoint) {
        let tempLabel = UILabel(frame: label.frame)
        tempLabel.text = text
        tempLabel.textAlignment = label.textAlignment
        tempLabel.font = label.font
        tempLabel.backgroundColor = label.backgroundColor
        tempLabel.textColor = label.textColor
        label.superview?.addSubview(tempLabel)
        
        tempLabel.alpha = 0
        tempLabel.transform = CGAffineTransformMakeTranslation(offset.x, offset.y)
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tempLabel.alpha = 1
            tempLabel.transform = CGAffineTransformIdentity
            label.transform = CGAffineTransformMakeTranslation(offset.x, offset.y)
            label.alpha = 0
        }) { (finish) -> Void in
            label.text = text
            label.alpha = 1
            label.transform = CGAffineTransformIdentity
            tempLabel.removeFromSuperview()
        }
    }
    
    func departPlane() {
        let originCenter = planeImage.center
        UIView.animateKeyframesWithDuration(1.5, delay: 0, options: nil, animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.25, animations: { () -> Void in
                self.planeImage.center.x += 80
                self.planeImage.center.y -= 10
            })
            UIView.addKeyframeWithRelativeStartTime(0.1, relativeDuration: 0.4, animations: { () -> Void in
                self.planeImage.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI / 8))
            })
            UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.25, animations: { () -> Void in
                self.planeImage.center.x += 100
                self.planeImage.center.y -= 50
                self.planeImage.alpha = 0
            })
            UIView.addKeyframeWithRelativeStartTime(0.51, relativeDuration: 0.01, animations: { () -> Void in
                self.planeImage.transform = CGAffineTransformIdentity
                self.planeImage.center = CGPointMake(0, originCenter.y)
            })
            UIView.addKeyframeWithRelativeStartTime(0.55, relativeDuration: 0.45, animations: { () -> Void in
                self.planeImage.alpha = 1
                self.planeImage.center = originCenter
            })
        }, completion: nil)
    }
}