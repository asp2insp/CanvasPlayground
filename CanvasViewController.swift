//
//  CanvasViewController.swift
//  CanvasPlayground
//
//  Created by Kris Aldenderfer on 5/27/15.
//  Copyright (c) 2015 CodePathLab. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  
    var trayBottom: CGFloat!
    var startingY: CGFloat?
  
    override func viewDidLoad() {
        super.viewDidLoad()

        trayBottom = bottomConstraint.constant
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)

        switch sender.state {
        case .Began:
            startingY = point.y
        case .Changed:
            bottomConstraint.constant = (startingY! - point.y)
        case .Ended, .Cancelled:
            bottomConstraint.constant = (startingY! - point.y)
            trayBottom = bottomConstraint.constant
        case .Failed, .Possible:
            bottomConstraint.constant = trayBottom
        }
      
        trayView.setNeedsLayout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
