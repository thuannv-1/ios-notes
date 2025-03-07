//
//  CoreDataService.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

//import Foundation
//import CoreData

//struct CoreDataService {
//    static let shared = CoreDataService()
//    
//    private let persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "ios_notes")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//}
//
//extension CoreDataService {
//    
//}
//
//extension NSManagedObjectContext {
//    func saveNote(_ note: Note) throws {
//        let cdNote = NoteEntity(context: self)
//        cdNote.id = note.id
//        cdNote.title = note.title
//        cdNote.content = note.content
//        cdNote.updateAt = note.updatedAt
//        cdNote.deleteAt = note.deletedAt
//        try self.save()
//    }
//}


import CoreData
import UIKit

final class CoreDataService {
    static let shared = CoreDataService()

    private init() {}

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ios_notes") // ⚠️ Đổi thành tên file .xcdatamodeld
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("✅ Data saved!")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataService {
    
    // 📝 Thêm Note mới
    func addNote(title: String, content: String) {
        let note = NoteEntity(context: context)
        note.id = UUID()
        note.title = title
        note.content = content
        note.updateAt = Date()
        note.deleteAt = Date()
        saveContext()
    }

    // 🔍 Lấy danh sách tất cả Note
    func fetchNotes() -> [NoteEntity] {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "updateAt", ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Fetch error: \(error.localizedDescription)")
            return []
        }
    }
//
//    // 🗑️ Xóa Note
//    func deleteNote(_ note: CDNote) {
//        context.delete(note)
//        saveContext()
//    }
//
//    // 🔄 Cập nhật Note
//    func updateNote(_ note: CDNote, newTitle: String, newContent: String) {
//        note.title = newTitle
//        note.content = newContent
//        note.updatedAt = Date()
//        saveContext()
//    }
}

extension NoteEntity {
    
}
