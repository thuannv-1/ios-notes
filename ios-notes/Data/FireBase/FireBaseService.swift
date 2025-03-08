//
//  FireBaseService.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import Foundation
import RxSwift
import FirebaseCore
import FirebaseFirestore

struct FirebaseService {
    
    static let shared = FirebaseService()
    
    func getNotes() -> Observable<[Note]> {
        return Observable.create { observer in
            Firestore.firestore().collection("notes-collection")
                .document("5zwvvSCPmciO0UhAOQiM")
                .getDocument { (document, error) in
                    if let error = error {
                        observer.onError(error)
                        return
                    }
                    
                    guard let document = document, document.exists else {
                        observer.onNext([])
                        observer.onCompleted()
                        return
                    }
                    
                    let data = document.data()?["data"] as? [[String: Any]] ?? []
                    let notes = data.mapToNotes()
                    
                    observer.onNext(notes)
                    observer.onCompleted()
                }
            
            return Disposables.create()
        }
    }
    
    func saveSyncNotes(_ notes: [Note]) {
        let collectionRef = Firestore.firestore().collection("notes-collection")
        let documentRef = collectionRef.document("5zwvvSCPmciO0UhAOQiM")
        let validNotes = notes.filter { !$0.isDeleted }
        
        let notesData: [[String: Any]] = validNotes.map { note in
            return [
                "id": note.id ?? "",
                "title": note.title ?? "",
                "content": note.content ?? "",
                "updatedAt": note.updatedAt?.toString(format: .dayMonthYearHour) ?? ""
            ]
        }

        documentRef.setData(["data": notesData], merge: true) { error in
            if let error = error {
                print("Error saving notes:", error.localizedDescription)
            } else {
                print("Notes saved successfully!")
            }
        }
    }
}

extension Array where Element == [String: Any] {
    func mapToNotes() -> [Note] {
        return self.compactMap { dict in
            let id = dict["id"] as? String
            let title = dict["title"] as? String
            let content = dict["content"] as? String
            let updatedAt = dict["updatedAt"] as? String
            let deletedAt = dict["deletedAt"] as? String
            
            return Note(
                id: id,
                title: title,
                content: content,
                updatedAt: updatedAt?.toDate(format: .dayMonthYearHour),
                deletedAt: deletedAt?.toDate(format: .dayMonthYearHour)
            )
        }
    }
}
