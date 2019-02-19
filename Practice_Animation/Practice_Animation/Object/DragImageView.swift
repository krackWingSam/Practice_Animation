//
//  DragImageView.swift
//  Practice_Animation
//
//  Created by 강상우 on 19/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

struct DragImageParams {
    var duration        : TimeInterval!
    var delay           : TimeInterval!
    var damping         : CGFloat!
    var velocity        : CGFloat!
}

class DragImageView: UIImageView {
    var params              : DragImageParams!
    var originalLocation    : CGPoint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.params = DragImageParams()
        params.duration = 1.0
        params.delay = 0
        params.damping = 0.2
        params.velocity = 0.2
    }
    
    
    // MARK: touch actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentPoint : CGPoint! = touches.first?.location(in: self.superview)
        self.center = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: self.params.duration,
                       delay: self.params.delay,
                       usingSpringWithDamping: self.params.damping,
                       initialSpringVelocity: self.params.velocity,
                       options: .curveLinear,
                       animations: {
            self.center = self.originalLocation
        }) { (Bool) in
            
        }
    }
}
