//
//  ViewController.swift
//  VEBannerControl
//
//  Created by XieBin on 2018/4/25.
//  Copyright © 2018年 XieBin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var bannerView: BannerControl = {
        let tempView = BannerControl.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/4))
        tempView.viewTpye = .HorizontalType
        return tempView
    }()
    
    lazy var bannerView2: BannerControl = {
        let tempView = BannerControl.init(frame: CGRect.init(x: 0, y: bannerView.frame.maxY, width: view.bounds.width, height: view.bounds.height/4))
        tempView.viewTpye = .NumberType
        return tempView
    }()
    
    lazy var bannerView3: BannerControl = {
        let tempView = BannerControl.init(frame: CGRect.init(x: 0, y: bannerView2.frame.maxY, width: view.bounds.width, height: view.bounds.height/4))
        tempView.viewTpye = .CustomType
        return tempView
    }()
    
    lazy var bannerView4: BannerControl = {
        let tempView = BannerControl.init(frame: CGRect.init(x: 0, y: bannerView3.frame.maxY, width: view.bounds.width, height: view.bounds.height/4))
        tempView.viewTpye = .CommonType
        return tempView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let imagesArr = ["https://gdp.alicdn.com/imgextra/i1/2448918848/TB2wn2snh1YBuNjy1zcXXbNcXXa_!!2448918848.jpg",
                         "https://gdp.alicdn.com/imgextra/i2/2448918848/TB2p5m7nHuWBuNjSszgXXb8jVXa_!!2448918848.jpg",
                         "https://gdp.alicdn.com/imgextra/i1/2448918848/TB238EWdRjTBKNjSZFuXXb0HFXa_!!2448918848.jpg",
                         "https://gdp.alicdn.com/imgextra/i3/279512537/TB2N2bCnXuWBuNjSspnXXX1NVXa_!!279512537.jpg",
                         "https://gdp.alicdn.com/imgextra/i4/279512537/TB2v8sEh3mTBuNjy1XbXXaMrVXa-279512537.jpg",
                         "https://cdn.ctfmall.com/path/lunbo588.jpg",
                         "https://cdn.ctfmall.com/path/lunbo558.jpg",
                         "https://cdn.ctfmall.com/path/luozuandingzhi111.jpg"]
        
        view.addSubview(bannerView)
        bannerView.imageArr = imagesArr
        bannerView.openTimer()
        
        view.addSubview(bannerView2)
        bannerView2.imageArr = imagesArr
        
        view.addSubview(bannerView3)
        bannerView3.imageArr = imagesArr
        bannerView3.openTimer()
        
        view.addSubview(bannerView4)
        bannerView4.imageArr = imagesArr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

