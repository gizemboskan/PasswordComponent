//
//  PasswordComponentViewController.swift
//  PasswordComponent
//
//  Created by Gizem Boskan on 4.04.2022.
//

import UIKit

final class PasswordComponentViewController: UIViewController {
    
    let stackView = UIStackView()
    let newPasswordTextFieldView = PasswordTextFieldView(placeHolderText: "New password")
    
    override func viewDidLoad() {
        style()
        layout()
    }
}

private extension PasswordComponentViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20.0
        
        newPasswordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        stackView.addArrangedSubview(newPasswordTextFieldView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            newPasswordTextFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            newPasswordTextFieldView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2.0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: newPasswordTextFieldView.trailingAnchor, multiplier: 2.0)
        ])
    }
}
