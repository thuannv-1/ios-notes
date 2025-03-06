//
//  AppViewModel.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import RxCocoa
import RxSwift

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

extension AppViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        
        input.loadTrigger
            .drive(onNext: {
                self.navigator.toHome()
            })
            .disposed(by: disposeBag)
        
        return Output(
            
        )
    }
}
