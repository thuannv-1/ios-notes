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
        let revertTrigger: Driver<Void>
    }
    
    struct Output {
        let mode: Driver<NoteDetailMode>
        let currentNote: Driver<Note?>
        let isContentChanged: Driver<Bool>
        let voidActions: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let currentMode = input.loadTrigger
            .map { mode }
        
        let currentNote = input.loadTrigger
            .map { note }
        
        let newNote = input.textTrigger
            .map { $0?.toNote(id: note?.id) }
            .unwrap()
        
        let isContentChanged = Driver.combineLatest(
            currentNote,
            newNote
        )
            .map {
                return $0?.fullContent != $1.fullContent
            }
        
        let addNew = input.saveTrigger
            .filter { _ in mode == .addNew }
            .withLatestFrom(newNote)
            .flatMapLatest {
                useCase.addNote(note: $0)
                    .asDriverOnErrorJustComplete()
            }
            .do { _ in navigator.pop() }
            .mapToVoid()
        
        let edit = input.saveTrigger
            .filter { _ in mode == .edit }
            .withLatestFrom(newNote)
            .flatMapLatest {
                useCase.updateNote(note: $0)
                    .asDriverOnErrorJustComplete()
            }
            .do { _ in navigator.pop() }
            .mapToVoid()
        
        let deleteNote = input.deleteTrigger
            .withLatestFrom(currentNote)
            .unwrap()
        
        let softDelete = deleteNote
            .filter { _ in mode == .edit }
            .flatMapLatest {
                useCase.softDelete(note: $0)
                    .asDriverOnErrorJustComplete()
            }
            .do { _ in navigator.pop() }
            .mapToVoid()
        
        let forceDelete = deleteNote
            .filter { _ in mode == .deleted }
            .flatMapLatest {
                useCase.forceDelete(note: $0)
                    .asDriverOnErrorJustComplete()
            }
            .do { _ in navigator.pop() }
            .mapToVoid()
        
        let revert = input.revertTrigger
            .filter { mode == .deleted }
            .withLatestFrom(currentNote)
            .unwrap()
            .flatMapLatest {
                useCase.revert(note: $0)
                    .asDriverOnErrorJustComplete()
            }
            .do { _ in navigator.pop() }
            .mapToVoid()
        
        let voidActions = Driver<Void>.merge(
            addNew,
            edit,
            softDelete,
            forceDelete,
            revert
        )
        
        return Output(
            mode: currentMode,
            currentNote: currentNote,
            isContentChanged: isContentChanged,
            voidActions: voidActions
        )
    }
}
