//
//  Date+String.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import Foundation

extension Date {
    func toString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}
