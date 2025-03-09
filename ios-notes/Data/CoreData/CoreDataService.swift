//
//  CoreDataService.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import CoreData
import UIKit
import RxSwift

protocol CoreDataServiceType {
    func addNote(note: Note) -> Observable<Note>
    func fetchNotes() -> Observable<[Note]>
    func deleteNote(note: Note) -> Observable<Bool>
    func updateNote(note: Note) -> Observable<Note>
    func saveSyncNotes(_ notes: [Note])
}

struct CoreDataService {
    private var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }
    
    private static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ios_notes")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}

extension CoreDataService: CoreDataServiceType {
    func addNote(note: Note) -> Observable<Note> {
        .create { observable in
            let entity = NoteEntity(context: context)
            entity.id = note.id
            entity.title = note.title
            entity.content = note.content
            entity.updatedAt = note.updatedAt
            
            do {
                try context.save()
                observable.onNext(note)
            } catch let error {
                observable.onError(error)
            }
            
            observable.onCompleted()
            return Disposables.create()
        }
    }
    
    func fetchNotes() -> Observable<[Note]> {
        .create { observable in
            let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
            
            do {
                let entities = try context.fetch(request)
                let notes = entities.toNotes()
                observable.onNext(notes)
                
            } catch let erorr {
                observable.onError(erorr)
            }
            
            observable.onCompleted()
            return Disposables.create()
            
        }
    }
    
    func deleteNote(note: Note) -> Observable<Bool> {
        .create { observable in
            let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", note.id ?? "")
            do {
                if let entity = try context.fetch(request).first {
                    context.delete(entity)
                }
                try context.save()
                observable.onNext(true)
            } catch let erorr {
                observable.onError(erorr)
            }
            
            observable.onCompleted()
            return Disposables.create()
        }
    }
    
    func updateNote(note: Note) -> Observable<Note> {
        return Observable.create { observable in
            let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", note.id ?? "")
            
            do {
                if let entity = try context.fetch(request).first {
                    entity.title = note.title
                    entity.content = note.content
                    entity.updatedAt = note.updatedAt
                    entity.deletedAt = note.deletedAt
                    
                    try context.save()
                    observable.onNext(note)
                    
                }
            } catch {
                observable.onError(error)
            }
            
            observable.onCompleted()
            return Disposables.create()
        }
    }
    
    func saveSyncNotes(_ notes: [Note]) {
        let context = self.context
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        do {
            let existingEntities = try context.fetch(fetchRequest)
            let existingNotesDict = Dictionary(uniqueKeysWithValues: existingEntities
                .map { ($0.id ?? "", $0) })
            
            for note in notes {
                if let existingNote = existingNotesDict[note.id ?? ""] {
                    if let existingUpdatedAt = existingNote.updatedAt,
                       existingUpdatedAt < note.updatedAt ?? Date() {
                        existingNote.title = note.title
                        existingNote.content = note.content
                        existingNote.updatedAt = note.updatedAt
                    }
                } else {
                    let newNoteEntity = NoteEntity(context: context)
                    newNoteEntity.id = note.id
                    newNoteEntity.title = note.title
                    newNoteEntity.content = note.content
                    newNoteEntity.updatedAt = note.updatedAt
                }
            }
            
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
