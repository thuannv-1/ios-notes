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
        AppAssembler.buildNoteDetail(
            navigationController: navigationController,
            mode: .addNew
        )
    }
    
    func toNoteDetail(data: Note) {
        AppAssembler.buildNoteDetail(
            navigationController: navigationController,
            mode: .edit,
            note: data
        )
    }
    
    func toRecycleBin() {
        print(#function)
    }
}
