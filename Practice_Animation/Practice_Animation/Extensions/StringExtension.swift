//
//  StringExtension.swift
//  Practice_Animation
//
//  Created by 강상우 on 18/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var timeIntervalValue: TimeInterval {
        return (self as NSString).doubleValue
    }
}
