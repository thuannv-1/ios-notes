//
//  UITextView+.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 7/3/25.
//

import UIKit

extension UITextView {
    func applyTitleStyling() {
        guard let text = self.text,
              !text.isEmpty else { return }
        
        let attributedText = NSMutableAttributedString(string: text)
        let lines = text.components(separatedBy: "\n")
        
        if let firstLine = lines.first {
            let titleRange = (text as NSString).range(of: firstLine)
            let titleFont = UIFont.boldSystemFont(ofSize: 24)
            let bodyFont = UIFont.systemFont(ofSize: 17)
            
            attributedText.addAttributes([.font: titleFont], range: titleRange)
            
            if lines.count > 1 {
                let bodyText = text.dropFirst(firstLine.count)
                let bodyRange = NSRange(location: titleRange.upperBound, length: bodyText.count)
                attributedText.addAttributes([.font: bodyFont], range: bodyRange)
            }
        }
        
        self.attributedText = attributedText
    }
}

extension UITextView {
    func addDismissButton() {
        let toolbar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: 44))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let icon = UIImage(systemName: "keyboard.chevron.compact.down",
                           withConfiguration: config)
        
        let doneButton = UIBarButtonItem(image: icon,
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        doneButton.tintColor = .systemOrange
        
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }
    
    @objc
    private func dismissKeyboard() {
        resignFirstResponder()
    }
}
