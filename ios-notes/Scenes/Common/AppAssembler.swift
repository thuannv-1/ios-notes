//
//  AppAssembler.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import UIKit

struct AppAssembler {
    static func buildNoteDetail(navigationController: UINavigationController,
                                mode: NoteDetailMode,
                                note: Note? = nil) {
        let useCase = NoteDetailUseCase()
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
}
