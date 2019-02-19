<style>
#background {
    height: 200px;
    width: 100%;
    position: relative;
    background: -webkit-linear-gradient(left, #74ebd5, #ACB6E5);
    background: -o-linear-gradient(right, #74ebd5, #ACB6E5);
    background: -moz-linear-gradient(right, #74ebd5, #ACB6E5);
    background: linear-gradient(to right, #74ebd5, #ACB6E5);
}

#title {
    text-align: center;
    line-height: 200px;
    font-size: 40px;
    font-weight: bold;
    -webkit-text-stroke: 2px green;
    -webkit-text-fill-color: transparent;
    width: 100%;
    position: absolute;
    right: 0px;
    bottom: 0px
}

#author {
    height: 40px;
    width: 100%;
    text-align: right;
    line-height: 40px;
    font-size: 20px;
    position: absolute;
    right: 40px;
    bottom: 0px;
    /*-webkit-text-stroke: 1px green;*/
    color: green;
    -webkit-text-fill-color: transparent;
    background-image: -webkit-linear-gradient(left, #74ebd5, #ACB6E5 25%, #74ebd5 50%, #ACB6E5 75%, #74ebd5);
    -webkit-background-clip: text;
    -webkit-background-size: 200% 100%;
    -webkit-animation: masked-animation 4s infinite linear;
    /*font-weight: bold;*/
}

@-webkit-keyframes masked-animation {
    0% {
        background-position: 0 0;
    }

    100% {
        background-position: -100% 0;
    }
}

#navi {
    overflow: hidden;
    background: white;
}

.item {
    float: left;
    display: block;
    color: white;
    text-align: center;
    padding: 20px 6px 20px 0px;
    text-decoration: none;
}

.item div {
    float: left;
    display: block;
}

.left {
    background: #333333;
    border-radius: 4px 0px 0px 4px;
    color: white;
    font-size: 10px;
    padding: 4px 6px;
}

.right {
    background: #008000;
    border-radius: 0px 4px 4px 0px;
    color: white;
    font-size: 10px;
    padding: 4px 6px;
}
</style>

<div id="background">
    <div id="title">LTPopupController</div>
    <div id="author">TopSky</div>
</div>

<div id="navi">
    <div class="item">
        <div class="left">pod</div>
        <div class="right">0.0.1</div>
    </div>
    <div class="item">
        <div class="left">platform</div>
        <div class="right">ios</div>
    </div>
    <div class="item">
        <div class="left">license</div>
        <div class="right">MIT</div>
    </div>
</div>

```
LTPopupController是基于UIPresentationController的封装。
* 提供top、bottom、left、right、center方向弹出图层的能力。
* 可在controller中动态改变弹出视图的大小。
* 适配屏幕旋转，并可以自定义旋转大小
* 生命周期的自定义回调
```
## Requirements

* Xcode 9.0+
* Swift 4.2+
* iOS 8.0+

## Installation

* Pod
    
   LTPopupController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    ```
    pod 'LTPopupController'
    ```
    
    
    
      
## Usage
* 示例图
    ![A-w200](base.gif) ![B-w200](rotate.gif)           

* 常规用法

    可更改style来控制弹出图层的方向
    
    ```
    let vc = SubViewController()
    let popupVC = LTPopupPresentationController(presentedViewController: vc, presentingViewController: self, style: .bottom)
    vc.preferredContentSize = CGSize(width: 300, height: 300)
    vc.transitioningDelegate = popupVC
    present(vc, animated: true, completion: nil)
    ```
       
* 改变弹出图层大小

    ```
    vc.preferredContentSize = CGSize(width: 200, height: 300)
    ```
* 适配屏幕旋转
    
    * 自适应大小（屏幕旋转时宽高互换）
    
        ```
        popupVC.isAutoRotationSize = true
        ```
    * 指定旋转后的Size
    
        ```
        popupVC.isAutoRotationSize = true
        popupVC.rotationPreferredContentSize = CGSize(width: 150, height: 150)
        ```
* 支持修改的属性

    ```
    popupVC.dimmingColor = UIColor.green //蒙板颜色
    popupVC.initialDimmingAlpha = 0.2 //蒙板初始透明度
    popupVC.finalDimmingAlpha = 1 //蒙板结束透明度
    popupVC.isTapDismiss = false // 点击蒙板是否Dismiss
    popupVC.shadowRadius = 16 //阴影半径 
    popupVC.shadowColor = UIColor.red //阴影颜色
    popupVC.shadowOffset = CGSize(width: -10, height: -10) //阴影偏移量
    popupVC.shadowOpacity = 1 //阴影透明度
    popupVC.cornerRadius = 16 //圆角
    popupVC.presentedDuration = 0.7 //弹出图层动画时间
    popupVC.dismissDuration = 0.7 //图层消失动画时间
    popupVC.springVelocity = 1 //动画初始速度
    popupVC.isAppear = true //是否调用presentedViewController 生命周期Appear类函数
    
    ```

        
## License
LTPopupController is available under the MIT license. See the LICENSE file for more info.
    
    









