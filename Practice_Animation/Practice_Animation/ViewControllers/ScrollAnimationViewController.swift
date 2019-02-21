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
    var defaultAngle    :CGFloat!
    var defaultX        :CGFloat!
}

// MARK: -
// MARK: -
// MARK: ScrollAnimationViewController
class ScrollAnimationViewController: UIViewController, UIScrollViewDelegate, TouchScrollViewDelegate {
    
    @IBOutlet weak var scrollView           : UIScrollView!
    @IBOutlet weak var view_Animate         : UIView!
    @IBOutlet weak var view_Fog             : UIView!
    @IBOutlet weak var label_Title          : UILabel!
    
    @IBOutlet weak var layout_Title_Bottom  : NSLayoutConstraint!
    @IBOutlet weak var layout_Fog_Center    : NSLayoutConstraint!
    
    
    let SCROLL_PAGE_COUNT          :Int     = 5     // 아이콘 갯수
    let SCROLL_ICON_MARGIN_ANGLE   :CGFloat = 18    // 원형 UI 에서의 각 아이콘 사이의 각도
    let SCROLL_ICON_LINEAR_MARGIN  :CGFloat = 40    // 아이콘의 Center 간격
    let SCROLL_ICON_LINEAR_Y_MARGIN:CGFloat = 30    // 선형 UI 에서의 하단과의 간격
    let ICON_SIZE                  :CGSize  = CGSize(width: 30, height: 30)
    
    var array_Icon                 : [IconSet?] = []
    var isOpenAnimation            : Bool       = false
    var currentIndex               : Int        = 0 // 현재 선택된 아이콘의 index
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//        self.initUI()
    }
    
    func initUI() {
        // constraints 를 적용한 상태에서의 후처리를 위해 layout이 적용된 후 init UI를 호출한다
        self.view.layoutIfNeeded()
        
        isOpenAnimation = false
        
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
        
        layout_Title_Bottom.constant = SCROLL_ICON_LINEAR_Y_MARGIN * 2
    }
    
    func initIcon() {
        // make icon set
        if (array_Icon.count > 0) {
            return
        }
        
        for i in 0..<SCROLL_PAGE_COUNT {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ICON_SIZE.width, height: ICON_SIZE.height))
            imageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: "Teacher_icon@2x", ofType: "png")!)
            
            // defaultX 값은 scrollView에 아이콘을 얹을 때 초기화
            let iconSet = IconSet(index: i, imageView: imageView, title: "icon "+String(i), defaultAngle: CGFloat(i)*18.0, defaultX: 0)
            array_Icon.append(iconSet)
        }
    }
    
    func initIconOnScrollView() {
        let frame = scrollView.frame
        var center = frame.size.width/2
        for i in 0..<SCROLL_PAGE_COUNT {
            let centerPoint = CGPoint(x: center, y: frame.size.height - 30)
            let imageView = array_Icon[i]?.imageView
            array_Icon[i]?.defaultX = centerPoint.x
            center += CGFloat(SCROLL_ICON_LINEAR_MARGIN)
            
            view_Animate.addSubview(imageView!)
        }
        self.calcLinearIconLocation()
        self.setScrollViewWidth()
    }
    
    func setScrollViewWidth() {
        // 스크롤 뷰 내부에 컨텐트가 존재하지 않기 때문에 constraints를 통해 ScrollView content size가 변경 될 때마다
        // 스크롤 뷰가 스크롤 가능토록 설정 해 주어야 한다
        let lastImageViewX: CGFloat! = array_Icon.last??.defaultX
        let contentWidth = lastImageViewX + scrollView.frame.size.width/2
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height)
    }
    
    func checkNewIndex() {
        // 인덱스가 바뀔 때마다 가벼운 진동을 주어 사용감을 높인다.
        var newIndex = self.getCurrentIndex()
        
        if newIndex < 0 {
            newIndex = 0
        }
        
        if newIndex >= SCROLL_PAGE_COUNT {
            newIndex = SCROLL_PAGE_COUNT - 1
        }
        
        if (currentIndex != newIndex) {
//            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
//            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            currentIndex = newIndex
        }
    }
    
    func setTitleForSelectedIcon() {
        self.label_Title.text = self.array_Icon[self.currentIndex]?.title
        self.setScrollViewWidth()
    }
    
    
    // MARK: -
    // MARK: Animations
    func getCurrentIndex() -> Int {
        // 스크롤뷰가 움직일 수 있는 거리는 SCROLL_ICON_LINEAR_MARGIN x (SCROLL_PAGE_COUNT - 1) 과 같다
        // 따라서 X 좌표가 움직인 거리에 비례하여 아이콘의 center 위치를 index 로 표현이 가능하다
        let currentOffsetX = self.scrollView.contentOffset.x + 20
        let index = Int(currentOffsetX/self.SCROLL_ICON_LINEAR_MARGIN)
        
        return index
    }
    
    func calcLinearIconLocation() {
        let frameX = scrollView.contentOffset.x
        for iconSet in array_Icon {
            iconSet?.imageView.center.x = iconSet!.defaultX - frameX
            iconSet?.imageView.center.y = scrollView.frame.size.height - CGFloat(SCROLL_ICON_LINEAR_Y_MARGIN)
        }
    }
    
    func calcCircleIconLocation() {
        // 호 내의 좌표 구하기
        // x = r * cos(angle)
        // y = r * sin(angle)
        
        let frameX = scrollView.contentOffset.x
        let movableAngle = SCROLL_ICON_MARGIN_ANGLE * CGFloat(SCROLL_PAGE_COUNT-1)
        let movableDistance = scrollView.contentSize.width - scrollView.frame.size.width
        let pixelPerAngle = movableAngle / movableDistance
        let angle = frameX * pixelPerAngle
        let r = view_Fog.frame.size.width/2 - SCROLL_ICON_LINEAR_MARGIN
        
        // 각 아이콘별 호 위의 좌표 계산
        for iconSet in array_Icon {
            let holder: CGFloat = (iconSet?.defaultAngle)!
            let realAngle: CGFloat! = (holder - angle - 90) * CGFloat(Double.pi) / 180
            let x: CGFloat = r * cos(realAngle) + scrollView.frame.size.width / 2
            let y: CGFloat = r * sin(realAngle) + view_Fog.frame.size.height + SCROLL_ICON_LINEAR_MARGIN*2
            iconSet?.imageView.center.x = x
            iconSet?.imageView.center.y = y
        }
    }
    
    func animation_Open() {
        if isOpenAnimation {
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.isOpenAnimation = true
            
            // set title label location
            self.layout_Title_Bottom.constant = self.view_Fog.frame.size.height/2 + self.label_Title.frame.size.height
            
            // Show half Circle with alpha/origin.y
            self.layout_Fog_Center.constant = 0
            self.view_Fog.alpha = 0.5
            self.calcCircleIconLocation()
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.isOpenAnimation = false
        }
    }
    
    func animation_Close() {
        self.animate_MoveToIconCenter()
        UIView.animate(withDuration: 0.2, animations: {
            self.layout_Title_Bottom.constant = self.SCROLL_ICON_LINEAR_Y_MARGIN * 2
            
            self.layout_Fog_Center.constant = self.view_Fog.frame.size.height/4
            self.view_Fog.alpha = 0.0
            self.calcLinearIconLocation()
            self.view.layoutIfNeeded()
        })
    }
    
    func animate_MoveToIconCenter() {
        // 스크롤 중 특정 아이콘의 위치로 강제 이동시키기 위한 함수
        // circle 부분은 고려할 필요 없이 구현한다
        UIView.animate(withDuration: 0.2) {
            let index = self.getCurrentIndex()
            let destinationOffsetX = (CGFloat(index) * self.SCROLL_ICON_LINEAR_MARGIN)
            self.scrollView.contentOffset.x = destinationOffsetX
        }
    }
    
    // MARK: -
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.checkNewIndex()
        self.animation_Open()
        UIView.animate(withDuration: 0.2) {
            self.calcCircleIconLocation()
        }
        
        DispatchQueue.main.async {
            self.label_Title.text = self.array_Icon[self.currentIndex]?.title
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.animation_Close()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.animation_Close()
    }
    
    func scrollViewTouchBegan() {
        self.animation_Open()
    }
    
    func scrollViewTouchEnded() {
        self.animation_Close()
    }
    
}


