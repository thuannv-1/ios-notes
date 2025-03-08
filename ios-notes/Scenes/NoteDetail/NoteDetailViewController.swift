//
//  NoteDetailViewController.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit
import RxSwift
import RxCocoa
import Then

final class NoteDetailViewController: BaseViewController {
    
    @IBOutlet private weak var inputTextView: UITextView!
    
    private lazy var deleteButton: UIBarButtonItem = {
        let icon = UIImage(systemName: "trash")
        let button = UIBarButtonItem(
            image: icon,
            style: .plain,
            target: nil,
            action: nil
        )
        button.tintColor = UIColor.systemOrange
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: nil,
            action: nil
        )
        button.tintColor = .systemOrange
        return button
    }()
    
    private lazy var revertButton: UIBarButtonItem = {
        let icon = UIImage(systemName: "arrow.counterclockwise.circle")
        let button = UIBarButtonItem(
            image: icon,
            style: .plain,
            target: nil,
            action: nil
        )
        button.tintColor = UIColor.systemOrange
        return button
    }()
    
    var viewModel: NoteDetailViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItems = [revertButton, saveButton, deleteButton]
        
        inputTextView.do {
            $0.tintColor = .systemOrange
            $0.font = .boldSystemFont(ofSize: 24)
            $0.delegate = self
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
            $0.smartQuotesType = .no
            $0.smartDashesType = .no
            $0.smartInsertDeleteType = .no
            $0.becomeFirstResponder()
            $0.addDismissButton()
            $0.applyTitleStyling()
        }
    }
    
    private func setupSaveButton(isActive: Bool) {
        saveButton.tintColor = isActive ? .systemOrange : .systemGray
        saveButton.isEnabled = isActive
    }
}

// MARK: - BindableType
extension NoteDetailViewController: BindableType {
    func bindViewModel() {
        
        let textTrigger = inputTextView.rx.text
            .distinctUntilChanged()
            .asDriverOnErrorJustComplete()
        
        let saveTrigger = saveButton.rx.tap
            .asDriver()
        
        let deleteTrigger = deleteButton.rx.tap
            .asDriver()
        
        let revertTrigger = revertButton.rx.tap
            .asDriver()
        
        let input = NoteDetailViewModel.Input(
            loadTrigger: .just(()),
            textTrigger: textTrigger,
            saveTrigger: saveTrigger,
            deleteTrigger: deleteTrigger,
            revertTrigger: revertTrigger
        )
        
        let output = viewModel.transform(input)
        
        output.mode
            .drive(modeBinder)
            .disposed(by: disposeBag)
        
        output.currentNote
            .drive(currentNoteBinder)
            .disposed(by: disposeBag)
        
        output.isContentChanged
            .drive(isContentChangedBinder)
            .disposed(by: disposeBag)
        
        output.voidActions
            .drive()
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .asDriverOnErrorJustComplete()
            .drive(keyboardWillShowBinder)
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .asDriverOnErrorJustComplete()
            .drive(keyboardWillHideBinder)
            .disposed(by: disposeBag)
    }
}

// MARK: - Binders
extension NoteDetailViewController {
    private var currentNoteBinder: Binder<Note?> {
        Binder(self) { vc, data in
            vc.inputTextView.text = data?.fullContent
            vc.inputTextView.applyTitleStyling()
        }
    }
    
    private var modeBinder: Binder<NoteDetailMode> {
        Binder(self) { vc, mode in
            switch mode {
            case .addNew:
                vc.deleteButton.isHidden = true
                vc.revertButton.isHidden = true
                vc.setupSaveButton(isActive: false)
                
            case .edit:
                vc.revertButton.isHidden = true
                
            case .deleted:
                vc.saveButton.isHidden = true
                vc.inputTextView.isEditable = false
                
            }
        }
    }
    
    private var isContentChangedBinder: Binder<Bool> {
        Binder(self) { vc, isChanged in
            vc.setupSaveButton(isActive: isChanged)
        }
    }
    
    private var keyboardWillShowBinder: Binder<Notification> {
        Binder(self) { vc, noti in
            guard let kbFrame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
            vc.inputTextView.contentInset.bottom = kbFrame.height
        }
    }
    
    private var keyboardWillHideBinder: Binder<Notification> {
        Binder(self) { vc, noti in
            vc.inputTextView.contentInset.bottom = 0
        }
    }
}

// MARK: - UITextViewDelegate
extension NoteDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            setupSaveButton(isActive: false)
        }
        textView.applyTitleStyling()
        let range = NSMakeRange(textView.text.count - 1, 1)
        textView.scrollRangeToVisible(range)
    }
}
