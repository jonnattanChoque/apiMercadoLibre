//
//  UIViewExtension.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import Foundation
import UIKit

extension UIView {
    
    /// Function to generate corner radius to a UIView
    /// - Parameters:
    ///   - corners: .topLeft, .topRight, .bottomLeft, .bottomRight, .allCorners
    ///   - radius: Float number
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
       let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
       let mask = CAShapeLayer()
       mask.path = path.cgPath
       layer.mask = mask
   }
}
