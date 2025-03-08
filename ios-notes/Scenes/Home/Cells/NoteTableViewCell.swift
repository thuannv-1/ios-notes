//
//  NoteTableViewCell.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 6/3/25.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        contentLabel.text = nil
    }
    
    private func setupUI() {
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 10.0
        containerView.applyShadow()
        
        titleLabel.font = .systemFont(ofSize: 17.0, weight: .semibold)
        titleLabel.textColor = .label
        
        contentLabel.font = .systemFont(ofSize: 15.0)
        contentLabel.textColor = .secondaryLabel
    }
}

extension NoteTableViewCell {
    func configCell(note: Note, searchKey: String?) {
        let content = note.content?.trimmingLeadingWhitespaceAndNewlines()
        if let searchKey = searchKey, !searchKey.isEmpty {
            titleLabel.attributedText = highlightText(note.title, searchKey: searchKey)
            contentLabel.attributedText = highlightText(content, searchKey: searchKey)
        } else {
            titleLabel.text = note.title
            contentLabel.text = content
        }
    }

    private func highlightText(_ text: String?, searchKey: String) -> NSAttributedString {
        guard let text = text else { return NSAttributedString(string: "") }
        
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: searchKey, options: .caseInsensitive)
        
        if range.location != NSNotFound {
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor.systemOrange,
                range: range
            )
            attributedString.addAttribute(
                .backgroundColor,
                value: UIColor.systemGray4.withAlphaComponent(0.3),
                range: range
            )
        }
        
        return attributedString
    }
}

