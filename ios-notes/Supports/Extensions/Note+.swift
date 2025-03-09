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
