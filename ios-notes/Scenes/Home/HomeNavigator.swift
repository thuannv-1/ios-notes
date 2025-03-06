//
//  HomeNavigator.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit

protocol HomeNavigatorType {
    func toNoteDetail()
}

struct HomeNavigator: NavigatorType {
    var navigationController: UINavigationController
}

extension HomeNavigator: HomeNavigatorType {
    func toNoteDetail() {
        let useCase = NoteDetailUseCase()
        let navigator = NoteDetailNavigator(navigationController: navigationController)
        let vm = NoteDetailViewModel(
            navigator: navigator,
            useCase: useCase
        )
        let vc = NoteDetailViewController()
        vc.bindViewModel(to: vm)
    }
}
