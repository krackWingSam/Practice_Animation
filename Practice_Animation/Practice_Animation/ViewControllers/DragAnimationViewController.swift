//
//  DragAnimationViewController.swift
//  Practice_Animation
//
//  Created by 강상우 on 18/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class DragAnimationViewController: UIViewController {
    
    @IBOutlet weak var view_Properties      : UIView!
    @IBOutlet weak var imageView            : DragImageView!
    
    @IBOutlet weak var slider_Duration      : UISlider!
    @IBOutlet weak var slider_Delay         : UISlider!
    @IBOutlet weak var slider_Damping       : UISlider!
    @IBOutlet weak var slider_Velocity      : UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view_Properties.frame.size = self.view.frame.size
        imageView.center = self.view.center
        imageView.originalLocation = self.view.center
    }

    
    // MARK: -IBActions
    @IBAction func action_ShowProperties(sender: UIBarButtonItem) {
        if view_Properties.superview != nil {
            return
        }
        
        view_Properties.frame.origin.y = self.view.frame.size.height
        self.view.addSubview(view_Properties)
        
        UIView.animate(withDuration: 0.2) {
            self.view_Properties.frame.origin.y = 0
        }
    }
    
    @IBAction func action_HideProperties(sender: UIButton) {
        imageView.params.duration   = TimeInterval(slider_Duration.value)
        imageView.params.delay      = TimeInterval(slider_Delay.value)
        imageView.params.damping    = CGFloat(slider_Damping.value)
        imageView.params.velocity   = CGFloat(slider_Velocity.value)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view_Properties.frame.origin.y = self.view.frame.size.height
        }) { (Bool) in
            self.view_Properties.removeFromSuperview()
        }
    }
}
