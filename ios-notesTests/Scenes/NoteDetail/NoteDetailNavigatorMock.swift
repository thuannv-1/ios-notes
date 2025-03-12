//
//  NoteDetailNavigatorMock.swift
//  ios-notesTests
//
//  Created by Thuan Nguyen on 9/3/25.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import ios_notes

class NoteDetailNavigatorMock: NoteDetailNavigatorType {
    var didCallPop = false
    
    func pop() {
        didCallPop = true
    }
}
