# 简介

* 封装轮播图控件
* 支持无限轮播和普通轮播两种模式
* 自定义的PageControl
* 定时器轮播手动加载

# 效果

![白色图片](https://github.com/jakebin/VEBannerControl/blob/master/Banner.gif)

# 用法

1. 懒加载BannerControl 对象
```objc
lazy var bannerView: BannerControl = {
    let tempView = BannerControl.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/4))
    tempView.viewTpye = .HorizontalType
    return tempView
}()
    
override func viewDidLoad() {
 super.viewDidLoad()
  
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
}
```
