//
//  HomeUseCase.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import RxSwift
import RxCocoa

protocol HomeUseCaseType {
    func getNotes() -> Observable<[Note]>
    func generateDataSource(searchKey: String?,
                            notes: [Note]) -> Observable<[NoteSection]>
}

struct HomeUseCase { }

extension HomeUseCase: HomeUseCaseType {
    func getNotes() -> Observable<[Note]> {
        CoreDataService.shared.fetchNotes()
            .map { $0.filterNotDeleted() }
    }
    
    func generateDataSource(searchKey: String?,
                            notes: [Note]) -> Observable<[NoteSection]> {
        .create { observable in
            guard let searchKey = searchKey,
                  !searchKey.isEmpty else {
                observable.onNext(notes.groupedByUpdateDate())
                observable.onCompleted()
                return Disposables.create()
            }
            
            let filteredNotes = notes.filter { note in
                let titleMatch = note.title?.localizedCaseInsensitiveContains(searchKey) == true
                let contentMatch = note.content?.localizedCaseInsensitiveContains(searchKey) == true
                return titleMatch || contentMatch
            }
            
            observable.onNext(filteredNotes.groupedByUpdateDate())
            observable.onCompleted()
            return Disposables.create()
        }
    }
}
