//
//  AppAssembler.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import UIKit

struct Assembler {
    static func buildHome(window: UIWindow) {
        let navigationController = UINavigationController()
        let navigator = HomeNavigator(navigationController: navigationController)
        let useCase = HomeUseCase(
            coreDataService: ServiceProvider.loadService(),
            fireBaseService: ServiceProvider.loadService()
        )
        let vm = HomeViewModel(navigator: navigator, useCase: useCase)
        let vc = HomeViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    static func buildNoteDetail(navigationController: UINavigationController,
                                mode: NoteDetailMode,
                                note: Note? = nil) {
        let useCase = NoteDetailUseCase(
            coreDataService: ServiceProvider.loadService()
        )
        let navigator = NoteDetailNavigator(navigationController: navigationController)
        let vm = NoteDetailViewModel(
            navigator: navigator,
            useCase: useCase,
            mode: mode,
            note: note
        )
        let vc = NoteDetailViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    static func buildTrash(navigationController: UINavigationController) {
        let useCase = TrashUseCase(
            coreDataService: ServiceProvider.loadService()
        )
        let navigator = TrashNavigator(navigationController: navigationController)
        let vm = TrashViewModel(
            navigator: navigator,
            useCase: useCase
        )
        let vc = TrashViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
