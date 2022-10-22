//
//  BGButton.swift
//  PesticideApp
//
//  Created by 永井歩武 on 2022/10/23.
//

// Button

import UIKit

@IBDesignable
class BGButton: UIButton {
    
    var gradientLayer = CAGradientLayer()
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    @IBInspectable var startColor: UIColor = UIColor.white {
        didSet {
            setGradient()
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.black {
        didSet {
            setGradient()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            setGradient()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            setGradient()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0.5) {
        didSet {
            setGradient()
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            setGradient()
        }
    }
    
    private func setGradient() {
        gradientLayer.removeFromSuperlayer()
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.frame.size = frame.size
        gradientLayer.frame.origin = CGPoint.init(x: 0.0, y: 0.0)
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.zPosition = -100
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.masksToBounds = true
        imageView?.layer.zPosition = 0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchStartAnimation()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchEndAnimation()
    }
    
  
//    RippleEffect Button
    
//    private func drawRipple(touch: UITouch) {
//        let rippleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        rippleView.layer.cornerRadius = 100
//        rippleView.center = touch.location(in: self)
//        rippleView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//        rippleView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
//        addSubview(rippleView)
//        UIView.animate(
//            withDuration: 0.3,
//            delay: 0.0,
//            options: UIView.AnimationOptions.curveEaseIn,
//            animations: {
//                rippleView.transform = CGAffineTransform(scaleX: 1, y: 1)
//                rippleView.backgroundColor = .clear
//            },
//            completion: { (finished: Bool) in
//                rippleView.removeFromSuperview()
//            }
//        )
//    }
    
    // タップ領域拡大
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var rect = bounds
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += insets.left + insets.right
        rect.size.height += insets.top + insets.bottom

        // 拡大したViewサイズがタップ領域に含まれているかどうかを返します
        return CGRectContainsPoint(rect, point)
    }
    
    func touchStartAnimation(duration: CGFloat = 0.01){
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {() -> Void in
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95);
            self.alpha = 0.7
        },completion: nil )
    }
    
    func touchEndAnimation(duration: CGFloat = 0.01){
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {() -> Void in
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            self.alpha = 1
        },completion: nil)
    }
}
