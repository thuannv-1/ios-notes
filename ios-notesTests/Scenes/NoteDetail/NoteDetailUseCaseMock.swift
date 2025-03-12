//
//  NoteDetailUseCaseMock.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 9/3/25.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import ios_notes

class NoteDetailUseCaseMock: NoteDetailUseCaseType {
    var didCallAddNote = false
    var didCallUpdateNote = false
    var didCallSoftDelete = false
    var didCallForceDelete = false
    var didCallRevert = false
    
    func addNote(note: Note) -> Observable<Note> {
        didCallAddNote = true
        return Observable.just(Note())
    }
    
    func updateNote(note: Note) -> Observable<Note> {
        didCallUpdateNote = true
        return Observable.just(Note())
    }
    
    func softDelete(note: Note) -> Observable<Note> {
        didCallSoftDelete = true
        return Observable.just(Note())
    }
    
    func forceDelete(note: Note) -> Observable<Bool> {
        didCallForceDelete = true
        return Observable.just(true)
    }
    
    func revert(note: Note) -> Observable<Note> {
        didCallRevert = true
        return Observable.just(Note())
    }
}
