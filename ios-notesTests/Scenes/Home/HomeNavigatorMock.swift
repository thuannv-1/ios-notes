//
//  HomeNavigatorMock.swift
//  ios-notesTests
//
//  Created by Thuan Nguyen on 9/3/25.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import ios_notes

class HomeNavigatorMock: HomeNavigatorType {
    var didCallAddNewNote = false
    var didCallToNoteDetail = false
    var didCallToRecycleBin = false
    var selectedNote: Note?

    func addNewNote() {
        didCallAddNewNote = true
    }

    func toNoteDetail(data: Note) {
        didCallToNoteDetail = true
        selectedNote = data
    }

    func toRecycleBin() {
        didCallToRecycleBin = true
    }
}
