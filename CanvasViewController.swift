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
    
    let openConstraintConstant : CGFloat = 0.0
    let closedConstraintConstant : CGFloat = -213.0
  
    var trayBottom: CGFloat!
    var startingY: CGFloat?
    var startingSmileyCenter: CGPoint?
  
    var newSmileyImageView: UIImageView!
  
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
            // TODO fix drag up
            bottomConstraint.constant = max(startingY! - point.y, closedConstraintConstant)
        case .Ended, .Cancelled:
            if velocity.y > 0 {
                bottomConstraint.constant = closedConstraintConstant
            } else {
                bottomConstraint.constant = openConstraintConstant
            }
        case .Failed, .Possible:
            bottomConstraint.constant = trayBottom
        }
      
        trayView.setNeedsLayout()
    }

    @IBAction func onSmileyPan(sender: UIPanGestureRecognizer) {
      var point = sender.locationInView(view)
      
      switch sender.state {
      case .Began:
        var imageView = sender.view as! UIImageView
        newSmileyImageView = UIImageView(image: imageView.image)
        view.addSubview(newSmileyImageView)
        newSmileyImageView.center = imageView.center
        newSmileyImageView.center.y += trayView.frame.origin.y
      case .Changed, .Ended, .Cancelled:
        newSmileyImageView.center.x = point.x
        newSmileyImageView.center.y = point.y
      case .Failed, .Possible:
        newSmileyImageView.center = startingSmileyCenter!
      }
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
