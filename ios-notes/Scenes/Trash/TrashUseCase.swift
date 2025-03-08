//
//  TrashUseCase.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import RxSwift
import RxCocoa

protocol TrashUseCaseType {
    func getNotes() -> Observable<[Note]>
    func generateDataSource(notes: [Note]) -> Observable<[NoteSection]>
}

struct TrashUseCase { }

extension TrashUseCase: TrashUseCaseType {
    func getNotes() -> Observable<[Note]> {
        CoreDataService.shared.fetchNotes()
            .map { $0.filterDeleted() }
    }
    
    func generateDataSource(notes: [Note]) -> Observable<[NoteSection]> {
        .create { observable in
            observable.onNext(notes.groupedByUpdateDate())
            observable.onCompleted()
            return Disposables.create()
        }
    }
}
