//
//  NoteDetailUseCase.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import RxSwift
import RxCocoa

protocol NoteDetailUseCaseType {
    func addNote(note: Note) -> Observable<Note>
    func updateNote(note: Note) -> Observable<Note>
    func softDelete(note: Note) -> Observable<Note>
    func forceDelete(note: Note) -> Observable<Bool>
    func revert(note: Note) -> Observable<Note>
}

struct NoteDetailUseCase {
    let coreDataService: CoreDataServiceType
}

extension NoteDetailUseCase: NoteDetailUseCaseType {
    func addNote(note: Note) -> Observable<Note> {
        coreDataService.addNote(note: note)
    }
    
    func updateNote(note: Note) -> Observable<Note> {
        coreDataService.updateNote(note: note)
    }
    
    func softDelete(note: Note) -> Observable<Note> {
        var newNote = note
        newNote.deletedAt = Date()
        return coreDataService.updateNote(note: newNote)
    }
    
    func forceDelete(note: Note) -> Observable<Bool> {
        coreDataService.deleteNote(note: note)
    }
    
    func revert(note: Note) -> Observable<Note> {
        var note = note
        note.deletedAt = nil
        return coreDataService.updateNote(note: note)
    }
}
