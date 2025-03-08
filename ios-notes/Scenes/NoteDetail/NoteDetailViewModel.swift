//
//  NoteDetailViewModel.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import Foundation
import RxCocoa
import RxSwift

enum NoteDetailMode {
    case addNew
    case edit
    case deleted
}

struct NoteDetailViewModel {
    let navigator: NoteDetailNavigatorType
    let useCase: NoteDetailUseCaseType
    var mode: NoteDetailMode
    var note: Note?
}

// MARK: - ViewModelType
extension NoteDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let textTrigger: Driver<String?>
        let saveTrigger: Driver<Void>
        let deleteTrigger: Driver<Void>
    }
    
    struct Output {
        let mode: Driver<NoteDetailMode>
        let currentNote: Driver<Note>
        let voidActions: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let currentMode = input.loadTrigger
            .map { mode }
        
        let currentNote = input.loadTrigger
            .map { note }
            .unwrap()
        
        let newNote = input.saveTrigger
            .withLatestFrom(input.textTrigger)
            .map { $0?.toNote() }
            .unwrap()
        
//        let activeSave = Driver.combineLatest(
//            currentNote,
//            newNote
//        )
//            .map { return $0.fullContent != $1.fullContent }
        
        let addNew = newNote
            .filter { _ in mode == .addNew }
            .flatMapLatest {
                useCase.addNote(note: $0)
                    .asDriverOnErrorJustComplete()
            }
            .do { _ in navigator.pop() }
            .mapToVoid()
        
        let edit = newNote
            .filter { _ in mode == .edit }
            .flatMapLatest {
                useCase.updateNote(note: $0)
                    .asDriverOnErrorJustComplete()
            }
            .mapToVoid()
        
        let delete = input.deleteTrigger
            .withLatestFrom(currentNote)
            .flatMapLatest {
                useCase.softDelete(note: $0)
                    .asDriverOnErrorJustComplete()
            }
            .do { _ in navigator.pop() }
            .mapToVoid()
        
        let voidActions = Driver<Void>.merge(
            addNew,
            edit,
            delete
        )
        
        return Output(
            mode: currentMode,
            currentNote: currentNote,
            voidActions: voidActions
        )
    }
}
