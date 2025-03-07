//
//  UISearchBar+.swift
//  ios-notes
//
//  Created by Thuan Nguyen on 7/3/25.
//

import UIKit

extension UISearchBar {
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
        
        let dismissButton = UIBarButtonItem(image: icon,
                                            style: .plain,
                                            target: self,
                                            action: #selector(dismissKeyboard))
        dismissButton.tintColor = .systemOrange
        
        toolbar.items = [flexSpace, dismissButton]
        toolbar.sizeToFit()
        
        searchTextField.inputAccessoryView = toolbar
    }
    
    @objc
    private func dismissKeyboard() {
        resignFirstResponder()
    }
}
