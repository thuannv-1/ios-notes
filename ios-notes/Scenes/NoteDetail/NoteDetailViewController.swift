//
//  NoteDetailViewController.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit
import RxSwift
import RxCocoa

class NoteDetailViewController: BaseViewController {

    var viewModel: NoteDetailViewModel!
    var disposeBag: DisposeBag! = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Notes"
    }
}

extension NoteDetailViewController: BindableType {
    func bindViewModel() {
        let input = NoteDetailViewModel.Input(
            loadTrigger: .just(())
        )
        
        let output = viewModel.transform(input)
        
        output.voidActions
            .drive()
            .disposed(by: disposeBag)
    }
}
