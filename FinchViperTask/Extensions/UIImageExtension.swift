//
//  UIImageExtension.swift
//  FinchViperTask
//
//  Created by Alex on 05.01.2022.
//

import UIKit

extension UIImage {
// https://stackoverflow.com/questions/38655374/how-to-set-corner-radius-to-uiimage-not-uiimageview-in-ios-swift
        public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
            let maxRadius = min(size.width, size.height) / 2
            let cornerRadius: CGFloat
            if let radius = radius, radius > 0 && radius <= maxRadius {
                cornerRadius = radius
            } else {
                cornerRadius = maxRadius
            }
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            draw(in: rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    }
