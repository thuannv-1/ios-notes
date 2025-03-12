//
//  TrashNavigatorMock.swift
//  ios-notesTests
//
//  Created by Thuan Nguyen on 9/3/25.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import ios_notes

class TrashNavigatorMock: TrashNavigatorType {
    var didCallToNoteDetail = false
    
    func toNoteDetail(data: Note) {
        didCallToNoteDetail = true
    }
}
