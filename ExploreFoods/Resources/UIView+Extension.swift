//
//  UIView+Extension.swift
//  ExploreFoods
//
//  Created by Altan on 24.02.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0) }
    }
}
