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
    let statusView = PasswordStatusView()
    let confirmPasswordTextFieldView = PasswordTextFieldView(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
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
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 5.0
        statusView.clipsToBounds = true
        
        confirmPasswordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        //        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(newPasswordTextFieldView)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextFieldView)
        stackView.addArrangedSubview(resetButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2.0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2.0),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
