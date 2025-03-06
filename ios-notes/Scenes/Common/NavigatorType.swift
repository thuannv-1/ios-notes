//
//  NavigatorType.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import Foundation
import UIKit

protocol NavigatorType {
    var navigationController: UINavigationController { get }
}

extension NavigatorType {
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func dissmiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
