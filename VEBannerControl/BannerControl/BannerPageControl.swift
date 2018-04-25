//
//  BannerPageControl.swift
//  ZRTStore
//
//  Created by 谨投 on 2018/2/1.
//  Copyright © 2018年 谨投. All rights reserved.
//

import UIKit

enum PointType: Int {
    case DotType
    case SquareType
}

class BannerPageControl: UIPageControl {

    lazy var dotSize = CGSize()
    lazy var roundAngle = CGFloat()
    var dotType = PointType(rawValue: 1)
    
    override var currentPage: Int {
        didSet{
           setupDotView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDotView() -> Void {
        
        switch dotType
        {
        case .DotType?:
            dotSize = CGSize.init(width: 7, height: 7)
            roundAngle = 3.5
            
        case .SquareType?:
            dotSize = CGSize.init(width: 13, height: 4)
            roundAngle = 0.0
            
        case .none: break
        }
        
        for index in 0..<subviews.count
        {
            let dotView: UIView = subviews[index]
            dotView.layer.cornerRadius = roundAngle
            dotView.layer.masksToBounds = true
            dotView.frame = CGRect.init(x: dotView.frame.origin.x, y: dotView.frame.origin.y, width: dotSize.width, height: dotSize.height)
            
            if index == currentPage
            {
                dotView.backgroundColor = currentPageIndicatorTintColor
            }
            else
            {
                dotView.backgroundColor = pageIndicatorTintColor
            }
        }
    }
}
