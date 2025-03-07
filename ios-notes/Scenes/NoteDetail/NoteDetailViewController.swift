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

class NoteDetailViewController: BaseViewController {
    
    @IBOutlet private weak var inputTextView: UITextView!
    
    private let saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: nil,
            action: nil
        )
        button.tintColor = .systemOrange
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        ]
        button.setTitleTextAttributes(attributes, for: .normal)
        return button
    }()
    
    var viewModel: NoteDetailViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = saveButton
        
        inputTextView.do {
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
}

extension NoteDetailViewController: BindableType {
    func bindViewModel() {
        let input = NoteDetailViewModel.Input(
            loadTrigger: .just(())
        )
        
        let output = viewModel.transform(input)
        
        output.data
            .drive(dataBinder)
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

extension NoteDetailViewController {
    private var dataBinder: Binder<Note> {
        Binder(self) { vc, data in
            vc.inputTextView.text = data.fullContent
            vc.inputTextView.applyTitleStyling()
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

extension NoteDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textView.applyTitleStyling()
        let range = NSMakeRange(textView.text.count - 1, 1)
        textView.scrollRangeToVisible(range)
    }
}
