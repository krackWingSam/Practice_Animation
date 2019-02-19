//
//  ScrollAnimationViewController.swift
//  Practice_Animation
//
//  Created by 강상우 on 19/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class ScrollAnimationViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView       : UIScrollView!
    @IBOutlet weak var view_Content     : UIView!
    
    let SCROLL_PAGE_COUNT = 5
    var array_Icon                      : [UILabel?] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    func initUI() {
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * 2, height: scrollView.frame.size.height)
        
        for i in 0..<SCROLL_PAGE_COUNT {
            let label: UILabel! = UILabel()
            label.text = String(i)
            label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            array_Icon.append(label)
        }
    }
    
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    
}
