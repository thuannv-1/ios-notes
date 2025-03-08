//
//  Note+.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 7/3/25.
//

import Foundation

extension Note {
    var fullContent: String? {
        return title?.appending("\n").appending(content ?? "")
    }
    
    var isDeleted: Bool {
        return deletedAt != nil
    }
}

extension Array where Element == Note {
    func groupedByUpdateDate() -> [NoteSection] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.dayMonthYear.rawValue
        
        let groupedNotes = Dictionary(grouping: self) { note in
            note.updatedAt.map { dateFormatter.string(from: $0) } ?? "Unknown Date"
        }
        
        return groupedNotes.map { key, value in
            NoteSection(
                header: key,
                cells: value.sorted {
                    $0.updatedAt ?? Date.distantPast > $1.updatedAt ?? Date.distantPast
                }
            )
        }
        .sorted { $0.header ?? "" > $1.header ?? "" }
    }
    
    func filterDeleted() -> [Note] {
        return filter{ $0.isDeleted }
    }
    
    func filterNotDeleted() -> [Note] {
        return filter { !$0.isDeleted }
    }
}
