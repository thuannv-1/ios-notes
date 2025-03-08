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
}

struct NoteDetailUseCase { }

extension NoteDetailUseCase: NoteDetailUseCaseType {
    func addNote(note: Note) -> Observable<Note> {
        CoreDataService.shared.addNote(note: note)
    }
    
    func updateNote(note: Note) -> Observable<Note> {
        CoreDataService.shared.addNote(note: note)
    }
    
    func softDelete(note: Note) -> Observable<Note> {
        var deletedNote = note
        deletedNote.deletedAt = Date()
        
        return CoreDataService.shared.updateNote(
            currentNote: note,
            newNote: deletedNote
        )
    }
}
