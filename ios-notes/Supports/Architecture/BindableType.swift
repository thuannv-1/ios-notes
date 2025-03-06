//
//  BindableType.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit
import RxSwift
import RxCocoa

protocol BindableType: AnyObject {
    associatedtype ViewModelType
    
    var disposeBag: DisposeBag! { get set }
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
