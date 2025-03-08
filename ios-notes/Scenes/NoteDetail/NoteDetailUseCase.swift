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

struct NoteDetailUseCase { }

extension NoteDetailUseCase: NoteDetailUseCaseType {
    func addNote(note: Note) -> Observable<Note> {
        CoreDataService.shared.addNote(note: note)
    }
    
    func updateNote(note: Note) -> Observable<Note> {
        CoreDataService.shared.updateNote(note: note)
    }
    
    func softDelete(note: Note) -> Observable<Note> {
        var newNote = note
        newNote.deletedAt = Date()
        return CoreDataService.shared.updateNote(note: newNote)
    }
    
    func forceDelete(note: Note) -> Observable<Bool> {
        CoreDataService.shared.deleteNote(note: note)
    }
    
    func revert(note: Note) -> Observable<Note> {
        var note = note
        note.deletedAt = nil
        return CoreDataService.shared.updateNote(note: note)
    }
}
