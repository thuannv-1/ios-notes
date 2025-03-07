//
//  NoteHeaderView.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit

class NoteHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    private func setupUI() {
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = .systemFont(ofSize: 13.0, weight: .medium)
    }
}

extension NoteHeaderView {
    func configView(title: String?) {
        titleLabel.text = title
    }
}
