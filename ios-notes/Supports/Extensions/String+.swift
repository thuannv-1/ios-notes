//
//  String+.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import Foundation

extension String {
    func trimmingLeadingWhitespaceAndNewlines() -> String {
        self.replacingOccurrences(of: #"^\s+"#, with: "", options: .regularExpression)
    }
}

extension String {
    func toNote() -> Note? {
        guard !self.isEmpty else {
            return nil
        }
        let lines = self.components(separatedBy: "\n")
        guard let title = lines.first else {
            return nil
        }
        let content = lines.dropFirst().joined(separator: "\n")
        
        return Note(
            id: UUID(),
            title: title,
            content: content,
            updatedAt: Date()
        )
    }
}
