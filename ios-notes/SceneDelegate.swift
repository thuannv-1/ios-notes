//
//  SceneDelegate.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit
import RxSwift
import RxCocoa

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var disposeBag = DisposeBag()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        bindViewModel(window: window)
    }
}

extension SceneDelegate {
    private func bindViewModel(window: UIWindow) {
        let navigator = AppNavigator(window: window)
        let useCase = AppUseCase()
        let viewModel = AppViewModel(navigator: navigator, useCase: useCase)
        let input = AppViewModel.Input(loadTrigger: .just(()))
        _ = viewModel.transform(input, disposeBag: disposeBag)
    }
}
