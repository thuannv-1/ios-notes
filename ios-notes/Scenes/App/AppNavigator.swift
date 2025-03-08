//
//  AppNavigator.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit

protocol AppNavigatorType {
    func toHome()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toHome() {
        Assembler.buildHome(window: window)
    }
}
