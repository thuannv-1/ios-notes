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
        let navigationController = UINavigationController()
        let navigator = HomeNavigator(navigationController: navigationController)
        let useCase = HomeUseCase()
        let vm = HomeViewModel(navigator: navigator, useCase: useCase)
        let vc = HomeViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
