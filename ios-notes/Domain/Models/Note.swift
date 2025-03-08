//
//  Note.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import Foundation

struct Note {
    var id: UUID?
    var title: String?
    var content: String?
    var updatedAt: Date?
    var deletedAt: Date?
    var rawValue: NoteEntity?
}
