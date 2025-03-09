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
    func getRemoteNotes() -> Observable<[Note]>
    func prepareSyncNotes(local: [Note],
                          remote: [Note]) -> [Note]
    func saveSyncNotes(notes: [Note])
    func generateDataSource(searchKey: String?,
                            notes: [Note]) -> Observable<[NoteSection]>
}

struct HomeUseCase {
    let coreDataService: CoreDataServiceType
    let fireBaseService: FirebaseServiceType
}

extension HomeUseCase: HomeUseCaseType {
    func getNotes() -> Observable<[Note]> {
        coreDataService.fetchNotes()
    }
    
    func getRemoteNotes() -> Observable<[Note]> {
        fireBaseService.getNotes()
    }
    
    func generateDataSource(searchKey: String?,
                            notes: [Note]) -> Observable<[NoteSection]> {
        .create { observable in
            let notes = notes.filterNotDeleted()
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
    
    func prepareSyncNotes(local: [Note], remote: [Note]) -> [Note] {
        var remoteDict = Dictionary(uniqueKeysWithValues: remote.map { ($0.id, $0) })
        var syncedNotes: [Note] = []
        for localNote in local {
            if localNote.isDeleted {
                if remoteDict[localNote.id] != nil {
                    remoteDict.removeValue(forKey: localNote.id)
                }
            } else {
                if var remoteNote = remoteDict[localNote.id] {
                    if (localNote.updatedAt ?? Date()) > (remoteNote.updatedAt ?? Date()) {
                        remoteNote.updatedAt = localNote.updatedAt
                        remoteNote.title = localNote.title
                        remoteNote.content = localNote.content
                    }
                    syncedNotes.append(remoteNote)
                    remoteDict.removeValue(forKey: localNote.id)
                } else {
                    syncedNotes.append(localNote)
                }
            }
        }
        syncedNotes.append(contentsOf: remoteDict.values)
        return syncedNotes
    }
    
    func saveSyncNotes(notes: [Note]) {
        coreDataService.saveSyncNotes(notes)
        fireBaseService.saveSyncNotes(notes)
    }
}
