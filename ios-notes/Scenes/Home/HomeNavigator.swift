//
//  HomeNavigator.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit

protocol HomeNavigatorType {
    func addNewNote()
    func toNoteDetail(data: Note)
    func toRecycleBin()
}

struct HomeNavigator: NavigatorType {
    var navigationController: UINavigationController
}

extension HomeNavigator: HomeNavigatorType {
    func addNewNote() {
        let useCase = NoteDetailUseCase()
        let navigator = NoteDetailNavigator(navigationController: navigationController)
        let vm = NoteDetailViewModel(
            navigator: navigator,
            useCase: useCase
        )
        let vc = NoteDetailViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toNoteDetail(data: Note) {
        let useCase = NoteDetailUseCase()
        let navigator = NoteDetailNavigator(navigationController: navigationController)
        let vm = NoteDetailViewModel(
            navigator: navigator,
            useCase: useCase,
            data: data
        )
        let vc = NoteDetailViewController()
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toRecycleBin() {
        print(#function)
    }
}
