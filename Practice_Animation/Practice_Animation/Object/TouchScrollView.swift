//
//  TouchScrollView.swift
//  Practice_Animation
//
//  Created by 강상우 on 20/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

protocol TouchScrollViewDelegate {
    func scrollViewTouchBegan()
    func scrollViewTouchEnded()
}

class TouchScrollView: UIScrollView {
    
    
    @IBOutlet open var touchScrollViewDelegate: Any?
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.touchScrollViewDelegate != nil {
            let touchDelegate = self.touchScrollViewDelegate as! TouchScrollViewDelegate
            touchDelegate.scrollViewTouchBegan()
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.touchScrollViewDelegate != nil {
            let touchDelegate = self.touchScrollViewDelegate as! TouchScrollViewDelegate
            touchDelegate.scrollViewTouchEnded()
        }
    }
}
