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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view_Properties.frame.size = self.view.frame.size
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func action_ShowProperties(sender: UIBarButtonItem) {
        
    }
}
