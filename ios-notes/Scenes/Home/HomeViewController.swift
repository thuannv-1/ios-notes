//
//  HomeViewController.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: HomeViewModel!
    var disposeBag: DisposeBag! = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Notes"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: BindableType {
    func bindViewModel() {
        let selectTrigger = tableView.rx.itemSelected
            .asDriver()
        
        let input = HomeViewModel.Input(
            loadTrigger: .just(()),
            selectTrigger: selectTrigger
        )
        
        let output = viewModel.transform(input)
        
        output.voidActions
            .drive()
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate,
                              UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
