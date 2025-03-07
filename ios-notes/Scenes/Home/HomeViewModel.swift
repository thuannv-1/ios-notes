//
//  HomeViewModel.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import Foundation
import RxCocoa
import RxSwift

struct NoteSection {
    var header: String?
    var cells: [Note]
}

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

// MARK: - ViewModelType
extension HomeViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let addNoteTrigger: Driver<Void>
        let searchTrigger: Driver<String?>
        let selectTrigger: Driver<IndexPath>
        let recycleBinTrigger: Driver<Void>
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
        
        let dataSource = Driver.combineLatest(input.searchTrigger,
                                              notes)
            .flatMap { text, data in
                useCase.generateDataSource(searchKey: text, notes: data)
                    .asDriverOnErrorJustComplete()
            }
        
        let addNote = input.addNoteTrigger
            .do(onNext: navigator.addNewNote)
        
        let select = input.selectTrigger
            .withLatestFrom(dataSource) { indexPath, dataSource in
                return dataSource[indexPath.section].cells[indexPath.row]
            }
            .do { data in
                navigator.toNoteDetail(data: data)
            }
            .mapToVoid()
        
        let toRecycleBin = input.recycleBinTrigger
            .do { _ in
                navigator.toRecycleBin()
            }
        
        let voidActions = Driver<Void>.merge(
            addNote,
            select,
            toRecycleBin
        )
        
        return Output(
            dataSource: dataSource,
            voidActions: voidActions
        )
    }
}
