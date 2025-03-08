//
//  String+Date.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import Foundation

enum DateFormat: String {
    case dayMonthYearHour = "dd/MM/yyyy HH:mm:ss"
    case dayMonthYear = "dd/MM/yyyy"
}

extension String {
    func toDate(format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: self)
    }
}
