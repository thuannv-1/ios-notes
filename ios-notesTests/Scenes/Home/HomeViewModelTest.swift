//
//  HomeViewModelTest.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 9/3/25.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import ios_notes

final class HomeViewModelTests: XCTestCase {
    
    private var viewModel: HomeViewModel!
    private var navigator = HomeNavigatorMock()
    private var useCase = HomeUseCaseMock()
    private var disposeBag = DisposeBag()
    
    private let loadTrigger = PublishSubject<Void>()
    private let refreshTrigger = PublishSubject<Void>()
    private let addNoteTrigger = PublishSubject<Void>()
    private let searchTrigger = BehaviorSubject<String?>(value: "")
    private let selectTrigger = PublishSubject<IndexPath>()
    private  let recycleBinTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel(navigator: navigator, useCase: useCase)
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            refreshTrigger: refreshTrigger.asDriverOnErrorJustComplete(),
            addNoteTrigger: addNoteTrigger.asDriverOnErrorJustComplete(),
            searchTrigger: searchTrigger.asDriverOnErrorJustComplete(),
            selectTrigger: selectTrigger.asDriverOnErrorJustComplete(),
            recycleBinTrigger: recycleBinTrigger.asDriverOnErrorJustComplete()
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
        XCTAssertTrue(useCase.didCallGetRemoteNotes)
        XCTAssertTrue(useCase.didCallPrepareSyncNotes)
        XCTAssertTrue(useCase.didCallSaveSyncNotes)
        XCTAssertTrue(useCase.didCallGenerateDataSource)
    }
    
    func test_addNoteTrigger() {
        addNoteTrigger.onNext(())
        XCTAssertTrue(navigator.didCallAddNewNote)
    }
    
    func test_selectTrigger() {
        let indexPath: IndexPath = [0, 1]

        loadTrigger.onNext(())
        wait { [weak self] in
            self?.selectTrigger.onNext(indexPath)
        }
        
        XCTAssertTrue(navigator.didCallToNoteDetail)
    }
    
    func test_recycleBinTrigger() {
        recycleBinTrigger.onNext(())
        
        XCTAssertTrue(navigator.didCallToRecycleBin)
    }
}
