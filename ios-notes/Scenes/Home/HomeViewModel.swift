//
//  HomeViewModel.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import Foundation
import RxCocoa
import RxSwift

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

// MARK: - ViewModelType
extension HomeViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let voidActions: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let voidActions = Driver<Void>.merge()
        
        return Output(
            voidActions: voidActions
        )
    }
}
