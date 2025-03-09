//
//  ServiceProvider.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 9/3/25.
//

import Foundation
import RxSwift
import RxCocoa

struct ServiceProvider {
    private static let services: [Any] = [
        FirebaseService(),
        CoreDataService()
    ]
    
    public static func loadService<T>() -> T {
        guard let service = services.first(where: { $0 is T }) as? T else {
            fatalError("No found service")
        }
        return service
    }
}
