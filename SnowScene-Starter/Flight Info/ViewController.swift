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
  
  //MARK: view controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //adjust ui
    summary.addSubview(summaryIcon)
    summaryIcon.center.y = summary.frame.size.height/2
    
    //start rotating the flights
    changeFlightDataTo(londonToParis)
    
    let rect = CGRectMake(0, -70, view.bounds.width, 50)
    let emitter = CAEmitterLayer()
    emitter.frame = rect
    emitter.emitterShape = kCAEmitterLayerRectangle
    emitter.emitterPosition = CGPointMake(rect.width / 2, rect.height / 2)
    emitter.emitterSize = rect.size
    view.layer.addSublayer(emitter)
    var emitterCells: [CAEmitterCell] = []
    for i in 0...4 {
        let  emitterCell = CAEmitterCell()
        if i != 0 {
            emitterCell.contents = UIImage(named: "flake\(i).png")!.CGImage
        }
        else {
            emitterCell.contents = UIImage(named: "flake.png")!.CGImage
        }
        emitterCell.birthRate = 40
        emitterCell.lifetime = 3.5
        emitterCell.lifetimeRange = 1.0
        emitterCell.yAcceleration = 70
        emitterCell.xAcceleration = 10
        emitterCell.emissionLongitude = CGFloat(-M_PI)
        emitterCell.emissionRange = CGFloat(M_PI_2)
        emitterCell.velocityRange = 200
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8
        emitterCell.scaleSpeed = -0.15
        emitterCell.alphaSpeed = -0.15
        emitterCell.alphaRange = 0.75
        emitterCell.redRange = 0.1
        emitterCell.greenRange  = 0.1
        emitterCell.blueRange = 0.1
        emitterCells.append(emitterCell)
    }
    emitter.emitterCells = emitterCells
  }
  
  //MARK: custom methods
  
  func changeFlightDataTo(data: FlightData) {
    
    // populate the UI with the next flight's data
    summary.text = data.summary
    flightNr.text = data.flightNr
    gateNr.text = data.gateNr
    departingFrom.text = data.departingFrom
    arrivingTo.text = data.arrivingTo
    flightStatus.text = data.flightStatus
    bgImageView.image = UIImage(named: data.weatherImageName)
  }
  
  
}