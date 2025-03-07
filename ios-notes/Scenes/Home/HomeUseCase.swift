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
        .create { observable in
            let notes: [Note] = [
                .init(id: UUID(), title: "Note 1", content: "Content 1 Bạn có thể điều chỉnh màu nền highlight mềm hơn bằng cách sử dụng màu nhạt hơn (ví dụ: Bạn có thể điều chỉnh màu nền highlight mềm hơn EEEZ cách sử dụng màu nhạt hơn (ví dụ:", updatedAt: Date()),
                .init(id: UUID(), title: "Note 1xx", content: "Content 1", updatedAt: Date()),
                .init(id: UUID(), title: "Note 1yy", content: "Content 1", updatedAt: Date()),
                .init(id: UUID(), title: "Note 2", content: "Content 2", updatedAt: Date().addingTimeInterval(100000)),
                .init(id: UUID(), title: "Note 31", content: "Content 3", updatedAt: Date().addingTimeInterval(-100000))
            ]
            observable.onNext(notes)
            observable.onCompleted()
            return Disposables.create()
        }
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
