//
//  UIViewController+Extension.swift
//  PasswordComponent
//
//  Created by Gizem Boskan on 6.04.2022.
//

import UIKit

extension UIViewController {
    func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc private func viewTapped() {
        view.endEditing(true) // resign first responder
    }
}
