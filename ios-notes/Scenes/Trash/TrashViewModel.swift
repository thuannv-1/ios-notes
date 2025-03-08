//
//  TrashViewModel.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import Foundation
import RxCocoa
import RxSwift

struct TrashViewModel {
    let navigator: TrashNavigatorType
    let useCase: TrashUseCaseType
}

// MARK: - ViewModelType
extension TrashViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let dataSource: Driver<[NoteSection]>
        let voidActions: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let notes = input.loadTrigger
            .flatMapLatest {
                useCase.getNotes()
                    .asDriverOnErrorJustComplete()
            }
        
        let dataSource = notes
            .flatMap { data in
                useCase.generateDataSource(notes: data)
                    .asDriverOnErrorJustComplete()
            }
        
        let select = input.selectTrigger
            .withLatestFrom(dataSource) { indexPath, dataSource in
                return dataSource[indexPath.section].cells[indexPath.row]
            }
            .do { data in
                navigator.toNoteDetail(data: data)
            }
            .mapToVoid()
        
        let voidActions = Driver<Void>.merge(
            select
        )
        
        return Output(
            dataSource: dataSource,
            voidActions: voidActions
        )
    }
}
