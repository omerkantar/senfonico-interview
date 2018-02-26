//
//  BakerView.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

// MARK: - BakerView (LGBTI+) Rainbows flag designer Gilbert Baker anisina gelistirdigim bir loading view 🌈
// https://github.com/omerkantar/BakerView/blob/master/BakerView.swift

fileprivate let kBakerViewHeight: CGFloat = 3.0
class BakerView: UIView {
    
    var rainbowLayer: CAGradientLayer?
    
    var colors: [CGColor]?
    
    var animationDuration: CGFloat = 0.1
}


// MARK: - Animation Start & Stop
extension BakerView {
    func startAnimation() {
        buildRainbowLayerIfNeeded()
        self.layer.addSublayer(rainbowLayer!)
        animating()
    }
    
    func stopAnimation() {
        self.removeRainbowLayer()
    }
}


// MARK: - CAAnimationDelegate
extension BakerView: CAAnimationDelegate {
    func animating() {
        if let rainbow = rainbowLayer,
            let colors = colors {
            
            let lastColor = colors.last
            self.colors?.remove(at: ((colors.endIndex) - 1))
            self.colors?.insert(lastColor!, at: 0)
            rainbow.colors = self.colors
            let animation = CABasicAnimation(keyPath: "colors")
            animation.toValue = self.colors
            animation.duration = CFTimeInterval(self.animationDuration)
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            animation.delegate = self
            rainbow.add(animation, forKey: "rainbow")
        }
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.rainbowLayer == nil {
            return
        }
        animating()
    }
}




// MARK: - Rainbow Layer
extension BakerView {
    
    func buildRainbowLayerIfNeeded() {
        if colors == nil {
            colors = self.getColors()
        }
        if rainbowLayer == nil {
            rainbowLayer = CAGradientLayer()
            rainbowLayer?.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
            rainbowLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
            rainbowLayer?.endPoint = CGPoint(x: 1.0, y: 0.5)
            rainbowLayer?.colors = colors
        }
    }
    
    func removeRainbowLayer() {
        if let rainbowLayer = rainbowLayer {
            rainbowLayer.removeAllAnimations()
            rainbowLayer.removeFromSuperlayer()
            self.rainbowLayer = nil
        }
        self.removeFromSuperview()
    }
    
    
    func getColors() -> [CGColor] {
        var colors = [CGColor]()
        var hue = 0.0
        repeat {
            let color = UIColor(hue: CGFloat(1.0 * hue / 360.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            colors.append(color.cgColor)
            hue += 5.0
            
        } while hue <= 360.0
        return colors
    }
}

extension BakerView {
    enum FrameType: Int {
        case top = 1
        case bottom = 2
    }
}
extension BakerView {
    static func show(type: BakerView.FrameType, parentView: UIView? = nil) -> BakerView {
        let screenSize = UIScreen.main.bounds.size
        let view = BakerView(frame: CGRect(x: 0.0, y: 0.0, width: screenSize.width, height: kBakerViewHeight))
        switch type {
        case .bottom:
            var height = screenSize.height
            if let parentView = parentView {
                if parentView.isKind(of: UIScrollView.self) {
                    height = (parentView as! UIScrollView).contentSize.height
                } else {
                    height = parentView.bounds.height
                }
            }
            view.frame.origin.y = height - kBakerViewHeight
        default:
            break
        }
        view.startAnimation()
        if let parentView = parentView {
            parentView.addSubview(view)
        } else {
            (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(view)
        }
        return view
    }
}
