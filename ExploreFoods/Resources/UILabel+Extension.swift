//
//  UILabel+Extension.swift
//  ExploreFoods
//
//  Created by Altan on 14.03.2024.
//

import UIKit

extension UILabel {
    func addShadow(shadowColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffset: CGSize) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.masksToBounds = false
    }
}
