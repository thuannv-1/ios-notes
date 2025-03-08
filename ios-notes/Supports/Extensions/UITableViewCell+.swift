//
//  UITableViewCell+.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 7/3/25.
//

import UIKit

extension UITableViewCell {
    func displayAnimate(indexPath: IndexPath) {
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.3,
                       delay: 0.01 * Double(indexPath.row),
                       options: .curveEaseInOut,
                       animations: {
            self.alpha = 1
            self.transform = .identity
        })
    }
}
