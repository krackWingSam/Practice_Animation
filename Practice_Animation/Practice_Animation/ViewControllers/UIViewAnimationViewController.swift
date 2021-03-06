//
//  UIViewAnimationViewController.swift
//  Practice_Animation
//
//  Created by 강상우 on 18/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class UIViewAnimationViewController: UIViewController {
    
    @IBOutlet weak var view_Properties  :UIView!
    @IBOutlet weak var imageView        :UIImageView!
    @IBOutlet weak var button_Up        :UIButton!
    @IBOutlet weak var button_Down      :UIButton!
    @IBOutlet weak var button_Left      :UIButton!
    @IBOutlet weak var button_Right     :UIButton!
    
    @IBOutlet weak var label_Duration   :UILabel!
    @IBOutlet weak var label_Distance   :UILabel!
    
    @IBOutlet weak var button_CurveIn   :UIButton!
    @IBOutlet weak var button_CurveOut  :UIButton!
    
    var array_Buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        array_Buttons = [button_Up, button_Left, button_Right, button_Down]
        
        // init properties view
        view_Properties.frame.size = self.view.frame.size
        self.action_ResetImagePosition(sender: button_Up)
    }

    
    // MARK: -IBActions
    @IBAction func action_ResetImagePosition(sender: Any) {
        imageView.center = self.view.center
    }
    
    @IBAction func action_Animation(sender: UIButton) {
        // block all buttons before starting animation
        for button:UIButton in self.array_Buttons {
            button.isEnabled = false;
        }
        
        let distance = CGFloat((label_Distance.text?.floatValue)!)
        var position = imageView.frame.origin
        switch sender.tag {
        //up
        case 0: position.y -= distance
            break
        //left
        case 1: position.x -= distance
            break
        //right
        case 2: position.x += distance
            break
        //down
        case 3: position.y += distance
            break
        default:
            break
        }
        
        var animationOptions: UIView.AnimationOptions!
        
        if (button_CurveIn.isSelected && button_CurveOut.isSelected) {
            animationOptions = UIView.AnimationOptions.curveEaseInOut
        }
        else if (button_CurveIn.isSelected) {
            animationOptions = UIView.AnimationOptions.curveEaseIn
        }
        else if (button_CurveOut.isSelected) {
            animationOptions = UIView.AnimationOptions.curveEaseOut
        }
        else {
            animationOptions = UIView.AnimationOptions.curveLinear
        }
        
        let duration = label_Duration.text?.timeIntervalValue
        UIView.animate(withDuration: duration!, delay: 0, options: animationOptions, animations: {
            self.imageView.frame.origin = position
        }) { (Bool) in
            // unblock all buttons after animation
            for button:UIButton in self.array_Buttons {
                button.isEnabled = true;
            }
        }
    }
    
    @IBAction func action_ShowProperties(sender: UIBarButtonItem) {
        guard (view_Properties!.superview == nil) else {
            return
        }
        
        view_Properties.frame.origin.x = 0
        view_Properties.frame.origin.y = self.view.frame.size.height
        self.view.addSubview(view_Properties)
        
        // animation
        UIView.animate(withDuration: 0.2) {
            self.view_Properties.frame.origin.y = 0
        }
    }
    
    @IBAction func action_CloseProperties(sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view_Properties.frame.origin.y = self.view.frame.size.height
        }) { (Bool) in
            self.view_Properties.removeFromSuperview()
        }
    }
    
    @IBAction func action_UsingCurve(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
