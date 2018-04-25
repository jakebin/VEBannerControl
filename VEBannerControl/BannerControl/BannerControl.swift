//
//  BannerControl.swift
//  ZRTStore
//
//  Created by 谨投 on 2018/2/1.
//  Copyright © 2018年 谨投. All rights reserved.
//

import UIKit

import Kingfisher

// MARK: Kingfisher加载图片
func kingfisherImage(imageView: UIImageView, imageUrl: String) -> Void {
    
    let url = URL(string: imageUrl)
    imageView.kf.setImage(with: url)
}

enum BannerType: Int {
    case HorizontalType  // 水平
    case NumberType      // 数字指示
    case CustomType      // 自定义 方形指示
    case CommonType      // 不无限轮播
}

class BannerControl: UIView {
    
    var callBackSelectAction:((Int)->())?
    public var viewTpye = BannerType(rawValue: 1)
    private var timer: Timer?
    lazy var bannerScrollView = UIScrollView()
    lazy var isStop = Bool()

    lazy var pageCtrl: BannerPageControl = {
        let tempPageControl = BannerPageControl.init(frame: CGRect.init(x: 0, y: 0, width: bounds.width, height: 10))
        tempPageControl.dotType = viewTpye == .CustomType ? .SquareType : .DotType
        tempPageControl.center = CGPoint.init(x: bounds.width/2, y: bounds.maxY-12)
        tempPageControl.numberOfPages = imageArr.count
        tempPageControl.currentPage = 0
        tempPageControl.isUserInteractionEnabled = false
        tempPageControl.pageIndicatorTintColor = UIColor.init(white: 0.5, alpha: 0.8)
        tempPageControl.currentPageIndicatorTintColor = UIColor.white
        return tempPageControl
    }()
    
    lazy var pageNumberView: UIView = {
        let tempView = UIView.init(frame: CGRect.init(x: bounds.width-45, y: bounds.height-40, width: 30, height: 30))
        tempView.backgroundColor = UIColor.clear
        return tempView
    }()
    
    lazy var currentNumberLb: UILabel = {
        let tempLb = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: 30))
        tempLb.text = "1"
        tempLb.textColor = UIColor.white
        tempLb.font = UIFont.systemFont(ofSize: 13)
        tempLb.textAlignment = .right
        return tempLb
    }()
    
    lazy var totalNumberLb: UILabel = {
        let tempLb = UILabel.init(frame: CGRect.init(x: currentNumberLb.frame.maxX, y: 0, width: 15, height: 30))
        tempLb.text = String(format: "/%d",imageArr.count)
        tempLb.textColor = UIColor.white
        tempLb.font = UIFont.systemFont(ofSize: 13)
        tempLb.textAlignment = .left
        return tempLb
    }()
    
    var imageArr = [String]() {
        
        didSet{
            addBannerView()
            let count = viewTpye == .CommonType ? imageArr.count : imageArr.count + 2
            
            for index in 0..<count
            {
                let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(index) * bounds.width, y: 0, width: bounds.width, height: bounds.height))
                imageView.contentMode = .scaleToFill
                
                if viewTpye == .CommonType
                {
                    kingfisherImage(imageView: imageView, imageUrl: imageArr[index])
                }
                else
                {
                    if index == 0
                    {
                        kingfisherImage(imageView: imageView, imageUrl: imageArr.last!)
                    }
                    else if index == imageArr.count + 1
                    {
                        kingfisherImage(imageView: imageView, imageUrl: imageArr.first!)
                    }
                    else
                    {
                        kingfisherImage(imageView: imageView, imageUrl: imageArr[index-1])
                    }
                }
                
                bannerScrollView.addSubview(imageView)
            }
            
            if imageArr.count <= 1
            {
                bannerScrollView.contentSize = CGSize.init(width: 0, height: 0)
            }
            else
            {
                if viewTpye == .NumberType
                {
                    addSubview(pageNumberView)
                    pageNumberView.addSubview(currentNumberLb)
                    pageNumberView.addSubview(totalNumberLb)
                }
                else
                {
                    addSubview(pageCtrl)
                }
            }
        }
    }
    
    // pragma MARK: ------------- life cycle -------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBannerView() -> Void {
        
        bannerScrollView = UIScrollView.init(frame: bounds)
        addSubview(bannerScrollView)
        let number: CGFloat = CGFloat(viewTpye == .CommonType ? imageArr.count : imageArr.count + 2)
        bannerScrollView.contentSize = CGSize.init(width: bounds.width * number, height: bounds.height)
        bannerScrollView.isPagingEnabled = true
        bannerScrollView.bounces = viewTpye == .CommonType ? true : false
        bannerScrollView.showsHorizontalScrollIndicator = false
        bannerScrollView.delegate = self
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(imageTapAction))
        bannerScrollView.addGestureRecognizer(tapGesture)
        
        if viewTpye != .CommonType
        {
            bannerScrollView.contentOffset = CGPoint.init(x: bounds.width, y: 0)
        }
    }
    
    deinit {
        
        if timer != nil
        {
            stopTimer()
        }
    }
}


// pragma MARK: -------------- Action ----------------

extension BannerControl {
    
    func openTimer() -> Void {
        
        if imageArr.count > 0
        {
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .commonModes)
        }
    }
    
    func startTimer() -> Void {
        
        if isStop
        {
            openTimer()
        }
    }
    
    func stopTimer() -> Void {
        
        if timer != nil
        {
            timer?.invalidate()
            timer = nil
            isStop = true
        }
    }
    
    @objc func timerAction() -> Void {
        
        var xValue = CGFloat()
        
        if viewTpye == .CommonType
        {
            var pageNumber = pageCtrl.currentPage + 1
            
            if pageNumber == imageArr.count
            {
                pageNumber = 0
            }
            
            xValue = CGFloat(pageNumber) * bounds.width
        }
        else
        {
            xValue = bannerScrollView.contentOffset.x + bounds.width
        }
        
        bannerScrollView.setContentOffset(CGPoint.init(x: xValue, y: 0), animated: true)
    }
    
    @objc func imageTapAction() -> Void {
        
        callBackSelectAction?(pageCtrl.currentPage)
    }
}

// pragma MARK: ------------- Delegate ---------------

extension BannerControl: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if viewTpye == .CommonType
        {
            pageCtrl.currentPage = Int(floor((scrollView.contentOffset.x - self.bounds.width/2) / self.bounds.width))  + 1
        }
        else
        {
            if scrollView.contentOffset.x == 0
            {
                bannerScrollView.contentOffset = CGPoint.init(x: CGFloat(imageArr.count) * bounds.width, y: 0)
            }
            
            if scrollView.contentOffset.x == bannerScrollView.contentSize.width - bounds.width
            {
                bannerScrollView.contentOffset = CGPoint.init(x: bounds.width, y: 0)
            }
            
            let pageIndex = Int((bannerScrollView.contentOffset.x - bounds.width) / bounds.width)
            pageCtrl.currentPage = pageIndex
            currentNumberLb.text = String(format: "%d",pageIndex + 1)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
        startTimer()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        stopTimer()
    }
}
