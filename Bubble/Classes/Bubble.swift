//
//  Bubble.swift
//  Bubble
//
//  Created by goldmoment on 07/01/2017.
//  Copyright (c) 2017 goldmoment. All rights reserved.
//

import UIKit

public class Bubble {
    private static var maskView: UIView?
    private static var layers: [CAShapeLayer] = []
    public static var maskColor = UIColor.clear
    
    private enum CircleColor : String, Codable {
        case turquoise
        case blue
        case purple
        case violet
        case red
        case orange
        case clementine
        case gold
        case lightgreen
        case green
        case darkgreen
        
        func value() -> UIColor {
            switch self {
            case .turquoise:
                return UIColor(red: 5/225, green: 166/225, blue: 235/225, alpha: 0.5)
            case .blue:
                return UIColor(red: 30/225, green: 131/225, blue: 232/225, alpha: 0.5)
            case .purple:
                return UIColor(red: 152/225, green: 45/225, blue: 186/225, alpha: 0.5)
            case .violet:
                return UIColor(red: 191/225, green: 0/225, blue: 108/225, alpha: 0.5)
            case .red:
                return UIColor(red: 237/225, green: 0/225, blue: 32/225, alpha: 0.5)
            case .orange:
                return UIColor(red: 240/225, green: 88/225, blue: 0/225, alpha: 0.5)
            case .clementine:
                return UIColor(red: 247/225, green: 148/225, blue: 0/225, alpha: 0.5)
            case .gold:
                return UIColor(red: 250/225, green: 204/225, blue: 0/225, alpha: 0.5)
            case .lightgreen:
                return UIColor(red: 247/225, green: 235/225, blue: 0/225, alpha: 0.5)
            case .green:
                return UIColor(red: 192/225, green: 222/225, blue: 0/225, alpha: 0.5)
            case .darkgreen:
                return UIColor(red: 138/225, green: 207/225, blue: 0/225, alpha: 0.5)
            }
        }
    }
    
    private struct Circle: Codable {
        let x: Double
        let y: Double
        let r: Double
        let color: CircleColor
    }
    
    public class func showLogo(with contentMode: UIViewContentMode = .scaleAspectFit, touchable: Bool = true) {
        guard let window = UIApplication.shared.delegate?.window as? UIWindow else { return }
        
        var container: UIView?
        if !touchable {
            maskView?.removeFromSuperview()
            maskView = UIView(frame: window.frame)
            maskView?.backgroundColor = maskColor
            
            if let view = maskView {
                view.layer.zPosition = CGFloat(HUGE)
                window.rootViewController?.view.addSubview(view)
            }
            container = maskView
        } else {
            container = window.rootViewController?.view
        }
        
        guard let containerView = container else { return }
        
        // Calculator ratio and offsets
        var ratio: CGFloat = 0.0
        var offsetX: CGFloat = 0.0
        var offsetY: CGFloat = 0.0
        if contentMode == .scaleAspectFit {
            ratio = containerView.frame.width / 435.0
            offsetY = (containerView.frame.height - 454.0 * ratio) / 2
        } else {
            ratio = containerView.frame.height / 454.0
            offsetX = (containerView.frame.width - 435.0 * ratio) / 2
        }
        
        // Create cicle layers
        for circle in Bubble.loadData() {
            let point = CGPoint(x: CGFloat(circle.x) * ratio + offsetX, y: CGFloat(circle.y) * ratio + offsetY)
            let radius = CGFloat(circle.r) * ratio
            layers += [containerView.addCircleLayer(point: point, radius: radius, color: circle.color.value())]
        }
        
        // Add animation for each layer
        layers.forEach { (layer) in
            let translate1Animation = CABasicAnimation(keyPath: "position.y")
            translate1Animation.fromValue = layer.position.y + containerView.frame.height
            translate1Animation.toValue = layer.position.y
            translate1Animation.duration = 3
            translate1Animation.timingFunction = CAMediaTimingFunction(controlPoints: Float.random(), 1, Float.random(), 1)
            
            let opacity1Animation = CABasicAnimation(keyPath: "opacity")
            opacity1Animation.fromValue = 0
            opacity1Animation.toValue = 1
            opacity1Animation.duration = 3
            opacity1Animation.timingFunction = CAMediaTimingFunction(controlPoints: Float.random(), 1, Float.random(), 1)
            
            let translate2Animation = CABasicAnimation(keyPath: "position.y")
            translate2Animation.fromValue = layer.position
            translate2Animation.toValue = layer.position.y - containerView.frame.height
            translate2Animation.duration = 3
            translate2Animation.beginTime = 5
            translate2Animation.timingFunction = CAMediaTimingFunction(controlPoints: 1, Float.random(), 1, Float.random())
            
            let opacity2Animation = CABasicAnimation(keyPath: "opacity")
            opacity2Animation.fromValue = 1
            opacity2Animation.toValue = 0
            opacity2Animation.duration = 3
            opacity2Animation.beginTime = 5
            opacity2Animation.timingFunction = CAMediaTimingFunction(controlPoints: 1, Float.random(), 1, Float.random())
            
            let groupAnimations = CAAnimationGroup()
            groupAnimations.animations = [translate1Animation, opacity1Animation, translate2Animation, opacity2Animation]
            groupAnimations.duration = 8
            groupAnimations.repeatCount = HUGE
            groupAnimations.isRemovedOnCompletion = true
            
            layer.zPosition = CGFloat(HUGE)
            layer.add(groupAnimations, forKey: nil)
        }
    }
    
    public class func hideLogo() {
        maskView?.removeFromSuperview()
        layers.forEach { (layer) in
            layer.removeFromSuperlayer()
        }
    }
    
    private class func loadData() -> [Circle] {
        if let jsonData = Logos.appleLogo.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([Circle].self, from: jsonData)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return []
    }
}

extension UIView {
    func addCircleLayer(point: CGPoint, radius: CGFloat, color: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(arcCenter: point, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        layer.fillColor = color.cgColor
        
        self.layer.addSublayer(layer)
        return layer
    }
}

extension Float {
    static func random() -> Float {
        return Float(arc4random()) / Float(UINT32_MAX)
    }
}
