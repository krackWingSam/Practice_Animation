//
//  ScrollAnimationViewController.swift
//  Practice_Animation
//
//  Created by 강상우 on 19/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit


// MARK: -
struct IconSet {
    var index           :Int
    var imageView       :UIImageView
    var title           :String
    var defaultAngle    :CGFloat
}

// MARK: -
// MARK: -
// MARK: ScrollAnimationViewController
class ScrollAnimationViewController: UIViewController, UIScrollViewDelegate, TouchScrollViewDelegate {
    
    @IBOutlet weak var scrollView           : UIScrollView!
    @IBOutlet weak var view_Animate         : UIView!
    @IBOutlet weak var view_Fog             : UIView!
    
    @IBOutlet weak var layout_Fog_Center    : NSLayoutConstraint!
    
    
    let SCROLL_PAGE_COUNT   = 5
    let SCROLL_ICON_MARGIN  = 40
    
    var array_Icon                          : [IconSet?] = []
    var isOpenAnimation                     : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        self.initUI()
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.initUI()
    }
    
    func initUI() {
        isOpenAnimation = false
        
        // scrollView inner contents size set
        view_Animate.backgroundColor = UIColor.clear
        
        // fog set corner radius
        view_Fog.layer.cornerRadius = view_Fog.frame.size.width/2
        
        // setting scrollView
        scrollView.frame.origin = CGPoint(x: 0, y: 0)
        scrollView.frame.size = self.view_Animate.frame.size
        view_Animate.addSubview(scrollView)
        
        // set scrollView contentsize
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * 2, height: scrollView.frame.size.height)
        
        
        // init icon position on scrollView
        self.initIcon()
        self.initIconOnScrollView()
    }
    
    func initIcon() {
        // make icon set
        for i in 0..<SCROLL_PAGE_COUNT {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: "Teacher_icon@2x", ofType: "png")!)
            let iconSet = IconSet(index: i, imageView: imageView, title: String(i), defaultAngle: CGFloat(i)*18.0)
            array_Icon.append(iconSet)
        }
    }
    
    func initIconOnScrollView() {
        let frame = scrollView.frame
        var center = frame.size.width/2
        for i in 0..<SCROLL_PAGE_COUNT {
            let centerPoint = CGPoint(x: center, y: frame.size.height - 30)
            let imageView = array_Icon[i]?.imageView
            imageView?.center = centerPoint
            center += 50
            
            view_Animate.addSubview(imageView!)
        }
        
        let lastImageView = array_Icon.last??.imageView
        let contentWidth = (lastImageView?.center.x)! + scrollView.frame.size.width/2
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height)
    }
    
    // MARK: -
    // MARK: Animations
    func calcIconLocation() {
        // 호 내의 좌표 구하기
        // x = r * cos(angle)
        // y = r * sin(angle)
        
        let frameX = scrollView.contentOffset.x
        let angle = frameX * 0.36
        let r = view_Fog.frame.size.width/2 - 45
        for i in 0..<SCROLL_PAGE_COUNT {
            
        }
        // TODO: calc x, y
    }
    
    func animation_Open() {
        if isOpenAnimation {
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.isOpenAnimation = true
            
            // Show half Circle with alpha/origin.y
            self.layout_Fog_Center.constant = 0
            self.view_Fog.alpha = 0.5
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.isOpenAnimation = false
        }
    }
    
    func animation_Close() {
        UIView.animate(withDuration: 0.2, animations: {
            self.layout_Fog_Center.constant = self.view_Fog.frame.size.height/4
            self.view_Fog.alpha = 0.0
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: -
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.animation_Open()
        self.calcIconLocation()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            
        }
        else {
            print("end dragging")
            self.animation_Close()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("end decelerating")
        self.animation_Close()
    }
    
    func scrollViewTouchBegan() {
        print("touch began")
        self.animation_Open()
    }
    
    func scrollViewTouchEnded() {
        print("touch ended")
        self.animation_Close()
    }
    
}


