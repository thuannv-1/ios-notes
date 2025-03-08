//
//  TrashNavigator.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import UIKit

protocol TrashNavigatorType {
    func toNoteDetail(data: Note)
}

struct TrashNavigator: NavigatorType {
    var navigationController: UINavigationController
}

extension TrashNavigator: TrashNavigatorType {
    func toNoteDetail(data: Note) {
        Assembler.buildNoteDetail(
            navigationController: navigationController,
            mode: .deleted,
            note: data
        )
    }
}
