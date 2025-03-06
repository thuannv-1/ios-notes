//
//  CoreDataService.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import Foundation
import CoreData

struct CoreDataService {
    static let shared = CoreDataService()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ios_notes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
