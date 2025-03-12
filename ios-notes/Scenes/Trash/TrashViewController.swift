//
//  TrashViewController.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 8/3/25.
//

import UIKit
import RxSwift
import RxCocoa
import Then

final class TrashViewController: UIViewController {
    @IBOutlet private weak var emptyLabel: UILabel!
    
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: TrashViewModel!
    private let disposeBag = DisposeBag()
    
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
        title = "Trash"
        
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.sectionHeaderHeight = UITableView.automaticDimension
            $0.sectionFooterHeight = 12.0
            $0.separatorStyle = .none
            $0.register(UINib(nibName: "NoteTableViewCell", bundle: nil),
                        forCellReuseIdentifier: "NoteTableViewCell")
            $0.register(UINib(nibName: "NoteHeaderView", bundle: nil),
                        forHeaderFooterViewReuseIdentifier: "NoteHeaderView")
        }
    }
}

// MARK: - Bindable
extension TrashViewController: BindableType {
    func bindViewModel() {
        let loadTrigger = rx.methodInvoked(#selector(viewWillAppear(_:)))
            .asDriverOnErrorJustComplete()
            .mapToVoid()
        
        let selectTrigger = tableView.rx.itemSelected
            .asDriver()
        
        let input = TrashViewModel.Input(
            loadTrigger: loadTrigger,
            selectTrigger: selectTrigger
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
extension TrashViewController {
    private var dataSourceBinder: Binder<[NoteSection]> {
        Binder(self) { vc, data in
            vc.dataSource = data
            vc.emptyLabel.isHidden = !data.isEmpty
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TrashViewController: UITableViewDelegate,
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
        cell?.configCell(note: data)
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
