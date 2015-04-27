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

class ViewController: UIViewController {
    
    //MARK: IB outlets
    
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonMenu: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    //MARK: further class variables
    
    var slider: HorizontalItemList!
    var isMenuOpen = false
    var items: [Int] = [5, 6, 7]
    
    //MARK: class methods
    
    @IBAction func actionToggleMenu(sender: AnyObject) {
        isMenuOpen = !isMenuOpen
        for constrain in titleLabel.superview!.constraints() as! [NSLayoutConstraint] {
            if constrain.secondItem as? NSObject == titleLabel && constrain.secondAttribute == .CenterX {
                constrain.constant = isMenuOpen ? 100 : 0
                continue
            }
            if constrain.firstItem as? NSObject == titleLabel && constrain.firstAttribute == .CenterY {
                titleLabel.superview!.removeConstraint(constrain)
                let newConstrain = NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: titleLabel.superview, attribute: .CenterY, multiplier: isMenuOpen ? 0.67 : 1, constant: 0)
                newConstrain.active = true
            }
        }
        if isMenuOpen {
            slider = HorizontalItemList(inView: view)
            slider.didSelectItem = {(index) in
                println("add \(index)")
                self.items.append(index)
                self.tableView.reloadData()
                self.actionToggleMenu(self)
            }
            titleLabel.superview?.addSubview(slider)
        }
        else {
            slider.removeFromSuperview()
        }
        menuHeightConstraint.constant = isMenuOpen ? 200 : 60
        let angle = isMenuOpen ? CGFloat(M_PI_4) : CGFloat(0.0)
        buttonMenu.transform = CGAffineTransformMakeRotation(angle)
        titleLabel.text = isMenuOpen ? "Select Item" : "Packing List"
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .CurveEaseIn, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showItem(index: Int) {
        let imageView = UIImageView(image: UIImage(named: "summericons_100px_0\(index).png"))
        imageView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        imageView.layer.cornerRadius = 0.5
        imageView.layer.masksToBounds = true
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(imageView)
        
        let conX = NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: imageView.superview, attribute: .CenterX, multiplier: 1, constant: 0)
        conX.active = true
        
        let conWidth = NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.33, constant: 0)
        conWidth.active = true
        
        let conHeight = NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: imageView, attribute: .Width, multiplier: 1, constant: 0)
        conHeight.active = true
        
        let conY = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: imageView.frame.height)
        conY.active = true
        view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            conWidth.constant = 0
            conY.constant = -imageView.frame.height / 2
            imageView.layoutIfNeeded()
            }) {(finish) in
                conWidth.constant = -imageView.frame.width + 1
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    imageView.layoutIfNeeded()
                }, completion: { (finish) -> Void in
                    imageView.removeFromSuperview()
                })
        }
    }
}


let itemTitles = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: View Controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.rowHeight = 54.0
    }
    
    // MARK: Table View methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.accessoryType = .None
        cell.textLabel?.text = itemTitles[items[indexPath.row]]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\(items[indexPath.row]).png")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        showItem(items[indexPath.row])
    }
    
}