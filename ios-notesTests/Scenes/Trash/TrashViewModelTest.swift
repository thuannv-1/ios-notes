//
//  TrashViewModelTest.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 9/3/25.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import ios_notes

final class TrashViewModelTests: XCTestCase {
    
    private var viewModel: TrashViewModel!
    private var navigator = TrashNavigatorMock()
    private var useCase = TrashUseCaseMock()
    private var disposeBag = DisposeBag()
    
    private let loadTrigger = PublishSubject<Void>()
    private let selectTrigger = PublishSubject<IndexPath>()
    
    override func setUp() {
        super.setUp()
        viewModel = TrashViewModel(navigator: navigator, useCase: useCase)
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = TrashViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            selectTrigger: selectTrigger.asDriverOnErrorJustComplete()
        )
        
        let output = viewModel.transform(input)
        
        output.dataSource
            .drive()
            .disposed(by: disposeBag)
        
        output.voidActions
            .drive()
            .disposed(by: disposeBag)
    }
    
    func test_loadTrigger() {
        loadTrigger.onNext(())
        
        XCTAssertTrue(useCase.didCallGetNotes)
        XCTAssertTrue(useCase.didCallGenerateDataSource)
    }
    
    func test_selectTrigger() {
        let indexPath: IndexPath = [0, 1]

        loadTrigger.onNext(())
        wait { [weak self] in
            self?.selectTrigger.onNext(indexPath)
        }
        
        XCTAssertTrue(navigator.didCallToNoteDetail)
    }
}
