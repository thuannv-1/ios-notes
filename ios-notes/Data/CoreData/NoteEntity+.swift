//
//  NoteEntity+.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import CoreData

extension Array where Element == NoteEntity {
    func toNotes() -> [Note] {
        return self.map {
            Note(id: $0.id,
                 title: $0.title,
                 content: $0.content,
                 updatedAt: $0.updatedAt,
                 deletedAt: $0.deletedAt,
                 rawValue: $0)
        }
    }
}
