//
//  TouchAnimationViewController.swift
//  Practice_Animation
//
//  Created by 강상우 on 19/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class TouchAnimationViewController: UIViewController {
    
    @IBOutlet weak var view_AnimationTarget  : UIView!
    @IBOutlet weak var view_AnimationTarget2 : UIView!
    
    @IBOutlet weak var layout_Target2Width   : NSLayoutConstraint!
    @IBOutlet weak var layout_Target2CenterY  : NSLayoutConstraint!
    

    let target2OriginWidth : CGFloat = 260.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view_AnimationTarget2.alpha = 0.0
        view_AnimationTarget2.layer.cornerRadius = view_AnimationTarget2.frame.size.width/2
    }
    
    
    // MARK: -Animation
    func animation_Circle() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view_AnimationTarget.layer.cornerRadius = self.view_AnimationTarget.frame.size.width/2
            self.view_AnimationTarget2.alpha = 0.7
            
            self.layout_Target2CenterY.constant -= 10
            self.layout_Target2Width.constant = self.view.frame.size.width
            self.view_AnimationTarget2.layer.cornerRadius = self.view.frame.size.width/2
            self.view.layoutIfNeeded()
        })
    }
    
    func animation_Square() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view_AnimationTarget.layer.cornerRadius = 0
            self.view_AnimationTarget2.alpha = 0.0
            
            self.layout_Target2Width.constant = self.target2OriginWidth
            self.layout_Target2CenterY.constant += 10
            self.view_AnimationTarget2.layer.cornerRadius = self.target2OriginWidth/2
            self.view.layoutIfNeeded()
        })
    }
    
    
    // MARK: -IBAction
    @IBAction func action_TouchUp(_ sender: Any) {
        self.animation_Square()
    }
    
    @IBAction func action_TouchDown(_ sender: Any) {
        self.animation_Circle()
    }

}
