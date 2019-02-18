//
//  UILabelExtension.swift
//  Practice_Animation
//
//  Created by 강상우 on 18/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

extension UILabel {
    @IBAction func setValue(slider: UISlider!) {
        self.text = String(slider.value)
    }
}
