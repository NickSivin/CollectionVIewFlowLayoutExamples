//
//  UIColor+AppColors.swift
//  CollectionViewFlowLayoutExamples
//

import Foundation
import UIKit

extension UIColor {
    static var graphite: UIColor {
        return .colorFrom(red: 46, green: 46, blue: 46)
    }
}

extension UIColor {
    private static func colorFrom(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
