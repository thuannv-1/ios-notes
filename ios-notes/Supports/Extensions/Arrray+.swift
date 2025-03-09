//
//  Arrray+.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 9/3/25.
//

import Foundation

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
