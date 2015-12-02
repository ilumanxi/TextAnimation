//
//  ViewController.swift
//  TextAnimation
//
//  Created by lumanxi on 15/10/15.
//  Copyright © 2015年 fanfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    
    override func loadView() {
        super.loadView()
    }
    
    
    
    @IBOutlet weak var textLabel: UILabel!
    
    /// CALayer的另一个子类CAGradientLayer，这个类的作用就是能在Layer上绘制出渐变颜色的效果
    let gradientLayer = CAGradientLayer()
    
    var text = "DevTalking"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer.bounds = CGRect(x: 0, y: 0, width: backgroundView.frame.size.width, height: backgroundView.frame.size.height)
        gradientLayer.position = CGPoint(x: backgroundView.frame.size.width/2, y: backgroundView.frame.size.height/2)
        
        //既然CAGradientLayer可以绘制出渐变颜色的效果，那自然有颜色渐变的方向，所以这两行代码的作用就是设置颜色渐变的起始点和结束点，这两个属性共同决定了颜色渐变的方向
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        
        //CAGradientLayer是通过起始点和结束点的坐标位置来决定颜色渐变的方向的，起始点的默认值是(0.5, 0)，结束点的默认值是(0.5, 1)，也就是说默认的颜色渐变方向是沿垂直中线从上往下渐变的，我们在这里将它改成了沿水平中线从左往右渐变。
        
        gradientLayer.colors = [
            UIColor.blackColor().CGColor,
            UIColor.whiteColor().CGColor,
            UIColor.blackColor().CGColor
        ]
        
        
        gradientLayer.locations = [0.2, 0.5, 0.8]
        backgroundView.layer.addSublayer(gradientLayer)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
//        textLabel.text = text
        textAnimate(text)
        gradientLayer.mask = textLabel.layer
        gradinetAnimate()
    }
    
    func gradinetAnimate(){
        let gradient = CABasicAnimation(keyPath: "locations")
        gradient.fromValue = [0, 0, 0.25]
        gradient.toValue = [0.75, 1, 1]
        gradient.duration = 2.5
        gradient.repeatCount = HUGE
        gradientLayer.addAnimation(gradient, forKey: nil)
    }


    func textAnimate(text: String) {
        if text.characters.count > 0 {
            textLabel.text = "\(textLabel.text!)\(text.substringToIndex(text.startIndex.successor()))"
            delay(seconds: 0.4, completion: {
                self.textAnimate(text.substringFromIndex(text.startIndex.successor()))
            })
        }
    }

    func delay(seconds seconds: Double, completion:()->()) {
        let intervalTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(intervalTime, dispatch_get_main_queue(), {
            completion()
        })
    }

}

