//
//  NoteDetailViewModel.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import Foundation
import RxCocoa
import RxSwift

struct NoteDetailViewModel {
    let navigator: NoteDetailNavigatorType
    let useCase: NoteDetailUseCaseType
    var data: Note?
}

// MARK: - ViewModelType
extension NoteDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let data: Driver<Note>
        let voidActions: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let data = input.loadTrigger
            .map { self.data }
            .unwrap()
        
        let voidActions = Driver<Void>.merge()
        
        return Output(
            data: data,
            voidActions: voidActions
        )
    }
}
