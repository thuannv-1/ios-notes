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

protocol FirebaseServiceType {
    func getNotes() -> Observable<[Note]>
    func saveSyncNotes(_ notes: [Note])
}

struct FirebaseService { }

extension FirebaseService: FirebaseServiceType {
    func getNotes() -> Observable<[Note]> {
        // Simple func fetch data from Remote DB
        // In practice we need to design DB with more detailed fields
        
        
        return Observable.create { observer in
//            Firestore.firestore().collection("notes-collection")
//                .document("5zwvvSCPmciO0UhAOQiM")
//                .getDocument { (document, _) in
//                    guard let document = document, document.exists else {
//                        observer.onNext([])
//                        observer.onCompleted()
//                        return
//                    }
//                    
//                    let data = document.data()?["data"] as? [[String: Any]] ?? []
//                    let notes = data.mapToNotes()
//                    
//                    observer.onNext(notes)
//                    observer.onCompleted()
//                }
            
            
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func saveSyncNotes(_ notes: [Note]) {
        // Simple func save data to Remote DB
        
//        let collectionRef = Firestore.firestore().collection("notes-collection")
//        let documentRef = collectionRef.document("5zwvvSCPmciO0UhAOQiM")
//        let validNotes = notes.filter { !$0.isDeleted }
//        
//        let notesData: [[String: Any]] = validNotes.map { note in
//            return [
//                "id": note.id ?? "",
//                "title": note.title ?? "",
//                "content": note.content ?? "",
//                "updatedAt": note.updatedAt?.toString(format: .dayMonthYearHour) ?? ""
//            ]
//        }
//
//        documentRef.setData(["data": notesData], merge: true) { error in
//            if let error = error {
//                print("Error saving notes:", error.localizedDescription)
//            } else {
//                print("Notes saved successfully!")
//            }
//        }
    }
}
