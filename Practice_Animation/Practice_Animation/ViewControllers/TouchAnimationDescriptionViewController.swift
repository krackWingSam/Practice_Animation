//
//  TouchAnimationDescriptionViewController.swift
//  Practice_Animation
//
//  Created by 강상우 on 19/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class TouchAnimationDescriptionViewController: UIViewController {
    
    @IBOutlet weak var view_Circle : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.initUI()
    }
    
    func initUI() {
        view_Circle.layer.cornerRadius = view_Circle.frame.size.width/2
    }

}
