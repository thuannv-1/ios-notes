//
//  XCTestCase+.swift
//  ios-notesTests
//
//  Created by Thuan Nguyen on 9/3/25.
//

import Foundation
import XCTest

extension XCTestCase {
    func wait(interval: TimeInterval = 0.2, completion: @escaping (() -> Void)) {
        let exp = expectation(description: "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
            exp.fulfill()
        }
        
        waitForExpectations(timeout: interval + 5.0)
    }
}
