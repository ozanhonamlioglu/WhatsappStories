//
//  UIView+Extension.swift
//  WhatsappStories
//
//  Created by ozy on 5.10.2021.
//

import UIKit

extension UIView {
    
    func ovalToCircle(_ slope: CGFloat, _ height: CGFloat, _ clear: Bool?) {
        
        if (clear != nil && clear == true) {
            self.layer.mask?.removeFromSuperlayer()
            
        } else {
            let bezierPath = UIBezierPath(ovalIn: CGRect(x: -(slope - self.bounds.width) / 2, y: (self.bounds.height / 2) - (height / 2), width: slope, height: height))
            let shape = CAShapeLayer()
            shape.path = bezierPath.cgPath
            self.layer.mask = shape
        }
    
    }
    
}
