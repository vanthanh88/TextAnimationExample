//
//  SVGAnimationView.swift
//  funnykanji
//
//  Created by Ulaai on 7/20/16.
//  Copyright © 2016 Thanhnv. All rights reserved.
//

import UIKit
import SVGPath

class SVGAnimationView: UIView, CAAnimationDelegate {
    
    var animatedLayers: [CAShapeLayer] = []
    var animationPaths: [UIBezierPath] = []
    
    
    lazy var shapeLayer: CAShapeLayer = {
        
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 2)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1.0
        
        return shapeLayer
 
    }()
    
    var animationCount = 0
    
    override func awakeFromNib() {
//        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(replayAnimation))
        self.addGestureRecognizer(tapGesture)
        
        self.clipsToBounds = false
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 5
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.insertSublayer(shapeLayer, at: 0)

    }
    
    func replayAnimation() {
        if animationCount == animatedLayers.count {
            playAnimation(0)
        }
    }

    
    func playAnimation(_ delay: TimeInterval) {
        var delay = delay
        if animationPaths.count == animatedLayers.count {
            animationCount = 0
            for index in 0 ..< animatedLayers.count {
                let layer = animatedLayers[index]
                let path = animationPaths[index]
                layer.removeFromSuperlayer()
                self.perform(#selector(startAnimationLayer(_:)), with: [layer, path], afterDelay: delay, inModes: [RunLoopMode.commonModes])
                delay += 0.8
            }
        }
        
    }
    
    func stopAnimations() {
        self.layer.removeAllAnimations()
        NSObject.cancelPreviousPerformRequests(withTarget: self)

        
    }
    
    func playAnimationFromPath(_ s_Paths: String?) {
        if let s_Paths = s_Paths {
            let paths = s_Paths.components(separatedBy: "|")

            for path in paths {
                let layer = CAShapeLayer()
//                layer.transform = CATransform3DMakeScale(1.2, 1.2, 0.0)
                let bezierPath = UIBezierPath(svgPath: path)

                
                
                let layerBG = CAShapeLayer()
//                layerBG.transform = CATransform3DMakeScale(1.2, 1.2, 0.0)
                
                layerBG.fillColor = UIColor.clear.cgColor
                layerBG.strokeColor = UIColor.black.withAlphaComponent(0.2).cgColor
                layerBG.path = bezierPath.cgPath
                layerBG.lineWidth = 6
                self.layer.addSublayer(layerBG)
                
                layer.lineWidth = 6
                layer.path = bezierPath.cgPath
                layer.fillColor = UIColor.clear.cgColor
                layer.strokeColor = UIColor.black.cgColor

                animatedLayers.append(layer)
                animationPaths.append(bezierPath)
                
                
            }

        }
        
        playAnimation(1)
        
    }
    
    func startAnimationLayer(_ objects: AnyObject) {
        if objects is NSArray {
            if let l = (objects as! NSArray)[0] as? CAShapeLayer {
                self.layer.addSublayer(l)
                self.addAnimationToLayer(l, duration: 0.5)

            }
            if let p = (objects as! NSArray)[1] as? UIBezierPath {
                if var firstPoint = p.firstPoint() {
                    firstPoint.y -= 10
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                    label.font = UIFont.systemFont(ofSize: 15)
                    label.textColor = UIColor.white
                    label.layer.cornerRadius = label.frame.size.width/2
                    label.layer.masksToBounds = true
                    label.numberOfLines = 0
                    label.textAlignment = .center
                    label.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                    label.layer.borderColor = UIColor.lightGray.cgColor
                    label.layer.borderWidth = 1
                    label.text = "\(animationCount + 1)"
                    self.addSubview(label)
                    label.center = firstPoint
                    
                    let delayTime = DispatchTime.now() + Double(Int64(0.7 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: delayTime) {
                        label.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func addAnimationToLayer(_ layer: CAShapeLayer, duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.delegate = self
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = duration
        layer.add(animation, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationCount += 1
    }
    
    
}
