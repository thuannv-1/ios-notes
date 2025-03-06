//
//  NoteDetailNavigator.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit

protocol NoteDetailNavigatorType {
    func toNoteDetail()
}

struct NoteDetailNavigator: NavigatorType {
    var navigationController: UINavigationController
}

extension NoteDetailNavigator: NoteDetailNavigatorType {
    func toNoteDetail() {
        
    }
}
