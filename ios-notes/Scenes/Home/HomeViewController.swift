//
//  HomeViewController.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var addNewNoteButton: UIButton!
    @IBOutlet private weak var emptyLabel: UILabel!
    
    private lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl().with {
            $0.addTarget(
                self,
                action: #selector(refreshData),
                for: .valueChanged
            )
            $0.tintColor = .systemOrange
            $0.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }
    }()
    
    private let recycleBinButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Trash",
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
    
    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    private let refreshTrigger = PublishSubject<Void>()
    
    private var dataSource = [NoteSection]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Notes"
        navigationItem.rightBarButtonItem = recycleBinButton
        
        searchBar.do {
            $0.placeholder = "Search"
            $0.searchTextField.autocorrectionType = .no
            $0.searchTextField.spellCheckingType = .no
            $0.searchTextField.smartQuotesType = .no
            $0.searchTextField.smartDashesType = .no
            $0.searchTextField.smartInsertDeleteType = .no
            $0.addDismissButton()
        }
        
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.sectionHeaderHeight = UITableView.automaticDimension
            $0.sectionFooterHeight = 12.0
            $0.separatorStyle = .none
            $0.refreshControl = refreshControl
            $0.register(UINib(nibName: "NoteTableViewCell", bundle: nil),
                        forCellReuseIdentifier: "NoteTableViewCell")
            $0.register(UINib(nibName: "NoteHeaderView", bundle: nil),
                        forHeaderFooterViewReuseIdentifier: "NoteHeaderView")
        }
        
        addNewNoteButton.do {
            $0.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            $0.backgroundColor = .systemOrange
            $0.layer.cornerRadius = 26.0
            $0.clipsToBounds = true
            $0.tintColor = .white
            $0.applyShadow()
        }
        
        setupEmtpyLabel()
    }
    
    @objc
    private func refreshData() {
        refreshTrigger.onNext(())
    }
    
    private func setupEmtpyLabel() {
        let text = "Add notes by clicking the "
        let buttonText = " button below"
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "square.and.pencil")?.withTintColor(.systemOrange)
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.secondaryLabel
        ])
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        let buttonAttributedString = NSAttributedString(string: buttonText, attributes: [
            .foregroundColor: UIColor.secondaryLabel
        ])
        attributedString.append(imageString)
        attributedString.append(buttonAttributedString)
        
        emptyLabel.do {
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.attributedText = attributedString
            $0.isHidden = true
        }
    }
}

// MARK: - Bindable
extension HomeViewController: BindableType {
    func bindViewModel() {
        let loadTrigger = rx.methodInvoked(#selector(viewWillAppear(_:)))
            .asDriverOnErrorJustComplete()
            .mapToVoid()
        
        let selectTrigger = tableView.rx.itemSelected
            .asDriver()
        
        let addNoteTrigger = addNewNoteButton.rx.tap
            .asDriver()
        
        let searchTrigger = searchBar.rx.text
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asDriverOnErrorJustComplete()
        
        let recycleBinTrigger = recycleBinButton.rx.tap
            .asDriver()
        
        let input = HomeViewModel.Input(
            loadTrigger: loadTrigger,
            refreshTrigger: refreshTrigger.asDriverOnErrorJustComplete(),
            addNoteTrigger: addNoteTrigger,
            searchTrigger: searchTrigger,
            selectTrigger: selectTrigger,
            recycleBinTrigger: recycleBinTrigger
        )
        
        let output = viewModel.transform(input)
        
        output.dataSource
            .drive(dataSourceBinder)
            .disposed(by: disposeBag)
        
        output.voidActions
            .drive()
            .disposed(by: disposeBag)
    }
}

// MARK: - Binders
extension HomeViewController {
    private var dataSourceBinder: Binder<[NoteSection]> {
        Binder(self) { vc, data in
            vc.dataSource = data
            vc.refreshControl.endRefreshing()
            vc.emptyLabel.isHidden = !data.isEmpty
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate,
                              UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].cells.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource[indexPath.section].cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "NoteTableViewCell",
            for: indexPath
        ) as? NoteTableViewCell
        cell?.selectionStyle = .none
        cell?.configCell(note: data, searchKey: searchBar.text)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "NoteHeaderView"
        ) as? NoteHeaderView
        view?.configView(title: dataSource[section].header)
        return view
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.displayAnimate(indexPath: indexPath)
    }
}
