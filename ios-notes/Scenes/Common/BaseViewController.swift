//
//  BaseViewController.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    deinit {
        debugPrint(String(describing: type(of: self)) + " deinit")
    }
}
