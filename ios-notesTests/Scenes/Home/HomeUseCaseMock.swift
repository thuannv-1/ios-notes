//
//  HomeUseCaseMock.swift
//  ios-notesTests
//
//  Created by Thuan Nguyen on 9/3/25.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import ios_notes

import Foundation

class HomeUseCaseMock: HomeUseCaseType {
    var notes: [Note] = [
        Note(id: "mock_id_1", title: "mock_title_1", content: "mock_content_1"),
        Note(id: "mock_id_2", title: "mock_title_2", content: "mock_content_2")
    ]
    var remoteNotes: [Note] = []
    
    
    var didCallGetNotes = false
    var didCallGetRemoteNotes = false
    var didCallPrepareSyncNotes = false
    var didCallSaveSyncNotes = false
    var didCallGenerateDataSource = false
    
    func getNotes() -> Observable<[Note]> {
        didCallGetNotes = true
        return .just(notes)
    }
    
    func getRemoteNotes() -> Observable<[Note]> {
        didCallGetRemoteNotes = true
        return .just(remoteNotes)
    }
    
    func prepareSyncNotes(local: [Note], remote: [Note]) -> [Note] {
        didCallPrepareSyncNotes = true
        return local + remote
    }
    
    func saveSyncNotes(notes: [Note]) {
        didCallSaveSyncNotes = true
    }
    
    func generateDataSource(searchKey: String?, notes: [Note]) -> Observable<[NoteSection]> {
        didCallGenerateDataSource = true
        return Observable.just([NoteSection(header: nil, cells: notes)])
    }
}
