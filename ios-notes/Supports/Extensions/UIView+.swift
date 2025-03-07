//
//  UIView+.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 7/3/25.
//

import UIKit

extension UIView {
    func applyShadow(
        color: UIColor = .black,
        opacity: Float = 0.2,
        radius: CGFloat = 4,
        offset: CGSize = CGSize(width: 0, height: 2)
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.masksToBounds = false
    }
}
