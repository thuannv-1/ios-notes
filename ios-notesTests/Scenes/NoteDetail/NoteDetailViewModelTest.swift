//
//  NoteDetailViewModelTest.swift
//  ios-notesTests
//
//  Created by Thuan Nguyen on 9/3/25.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import ios_notes

final class NoteDetailViewModelTests: XCTestCase {
    
    private var viewModel: NoteDetailViewModel!
    private var navigator = NoteDetailNavigatorMock()
    private var useCase = NoteDetailUseCaseMock()
    private var disposeBag = DisposeBag()
    
    private let loadTrigger = PublishSubject<Void>()
    private let textTrigger = BehaviorSubject<String?>(value: nil)
    private let saveTrigger = PublishSubject<Void>()
    private let deleteTrigger = PublishSubject<Void>()
    private let revertTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        viewModel = NoteDetailViewModel(
            navigator: navigator,
            useCase: useCase,
            mode: .edit,
            note: Note(id: "1", title: "Note 1", content: "Content 1")
        )
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = NoteDetailViewModel.Input(
            loadTrigger: loadTrigger.asDriverOnErrorJustComplete(),
            textTrigger: textTrigger.asDriverOnErrorJustComplete(),
            saveTrigger: saveTrigger.asDriverOnErrorJustComplete(),
            deleteTrigger: deleteTrigger.asDriverOnErrorJustComplete(),
            revertTrigger: revertTrigger.asDriverOnErrorJustComplete()
        )
        
        let output = viewModel.transform(input)
        
        output.currentNote
            .drive()
            .disposed(by: disposeBag)
        
        output.mode
            .drive()
            .disposed(by: disposeBag)
        
        output.isContentChanged
            .drive()
            .disposed(by: disposeBag)
        
        output.voidActions
            .drive()
            .disposed(by: disposeBag)
    }
    
    func test_loadTrigger() {
        loadTrigger.onNext(())
        
        XCTAssertEqual(viewModel.mode, .edit)
        XCTAssertEqual(viewModel.note?.title, "Note 1")
    }
    
    func test_saveTrigger_addNew() {
        viewModel.mode = .addNew
        bindViewModel()
        
        textTrigger.onNext("New Note Content")
        saveTrigger.onNext(())
        
        XCTAssertTrue(useCase.didCallAddNote)
        XCTAssertTrue(navigator.didCallPop)
    }
    
    func test_saveTrigger_edit() {
        viewModel.mode = .edit
        textTrigger.onNext("Updated Content")
        saveTrigger.onNext(())
        
        XCTAssertTrue(useCase.didCallUpdateNote)
        XCTAssertTrue(navigator.didCallPop)
    }
    
    func test_deleteTrigger_softDelete() {
        loadTrigger.onNext(())
        deleteTrigger.onNext(())
        
        XCTAssertTrue(useCase.didCallSoftDelete)
        XCTAssertTrue(navigator.didCallPop)
    }
    
    func test_deleteTrigger_forceDelete() {
        viewModel.mode = .deleted
        bindViewModel()
        loadTrigger.onNext(())
        deleteTrigger.onNext(())
        
        XCTAssertTrue(useCase.didCallForceDelete)
        XCTAssertTrue(navigator.didCallPop)
    }
    
    func test_revertTrigger() {
        viewModel.mode = .deleted
        bindViewModel()
        loadTrigger.onNext(())
        revertTrigger.onNext(())
        
        XCTAssertTrue(useCase.didCallRevert)
        XCTAssertTrue(navigator.didCallPop)
    }
}
