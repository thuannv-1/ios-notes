//
//  TrashUseCaseMock.swift
//  ios-notesTests
//
//  Created by Thuan Nguyen on 9/3/25.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import ios_notes

class TrashUseCaseMock: TrashUseCaseType {
    var notes: [Note] = [
        Note(id: "mock_id_1", title: "mock_title_1", content: "mock_content_1"),
        Note(id: "mock_id_2", title: "mock_title_2", content: "mock_content_2")
    ]
    var didCallGetNotes = false
    var didCallGenerateDataSource = false
    
    func getNotes() -> Observable<[Note]> {
        didCallGetNotes = true
        return Observable.just(notes)
    }
    
    func generateDataSource(notes: [Note]) -> Observable<[NoteSection]> {
        didCallGenerateDataSource = true
        return Observable.just([NoteSection(header: nil, cells: notes)])
    }
}
