//
//  CoreDataService.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import CoreData
import UIKit
import RxSwift

struct CoreDataService {
    static let shared = CoreDataService()

    private init() {}

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

extension CoreDataService {
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
            guard let noteEntity = note.rawValue else {
                observable.onCompleted()
                return Disposables.create()
            }
            context.delete(noteEntity)
            
            do {
                try context.save()
                observable.onNext(true)
            } catch let erorr {
                observable.onError(erorr)
            }
            
            observable.onCompleted()
            return Disposables.create()
        }
    }
    
    func updateNote(currentNote: Note?, newNote: Note) -> Observable<Note> {
        .create { observable in
            guard let currentEntity = currentNote?.rawValue else {
                observable.onCompleted()
                return Disposables.create()
            }
            currentEntity.title = newNote.title
            currentEntity.content = newNote.content
            currentEntity.updatedAt = Date()
            currentEntity.deletedAt = newNote.deletedAt
            
            do {
                try context.save()
                observable.onNext(newNote)
            } catch let erorr {
                observable.onError(erorr)
            }
            
            observable.onCompleted()
            return Disposables.create()
            
        }
    }
}
