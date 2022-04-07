//
//  PasswordComponentViewController.swift
//  PasswordComponent
//
//  Created by Gizem Boskan on 4.04.2022.
//

import UIKit

final class PasswordComponentViewController: UIViewController {
    
    typealias CustomValidation = PasswordTextFieldView.CustomValidation
    
    let stackView = UIStackView()
    let newPasswordTextFieldView = PasswordTextFieldView(placeHolderText: "New password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextFieldView = PasswordTextFieldView(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        style()
        layout()
        setup()
    }
}

// MARK: - Style & Layout
private extension PasswordComponentViewController {
    func setup() {
        setupDismissKeyboardGesture()
        setupNewPassword()
        setupConfirmPassword()
        setupKeyboardHiding()
    }
    
    func  setupNewPassword() {
        let newPasswordValidation: CustomValidation = { text in
            
            // Empty Text
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }
            
            // Invalid Characters
            let validChars = "abcdefghjklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$#\\/"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$#\\/) with no spaces.")
            }
            
            // Criteria met
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements below.")
            }
            
            return (true, "")
        }
        newPasswordTextFieldView.customValidation = newPasswordValidation
        newPasswordTextFieldView.delegate = self
    }
    
    func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            
            // Empty Text
            guard let text = text, !text.isEmpty else {
                return(false, "Enter your password")
            }
            
            // Passwords match
            guard text == self.newPasswordTextFieldView.text else  {
                return(false, "Passwords do not match.")
            }
            
            return (true, "")
        }
        confirmPasswordTextFieldView.customValidation = confirmPasswordValidation
        confirmPasswordTextFieldView.delegate = self
    }
    
    
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

// MARK: - PasswordTextFieldDelegate
extension PasswordComponentViewController: PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextFieldView) {
        if sender == newPasswordTextFieldView {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextFieldView) {
        if sender == newPasswordTextFieldView {
            // as soon as we lose focus, make (X) appear
            statusView.shouldResetCriteria = false
            _ = newPasswordTextFieldView.validate()
        } else if sender == confirmPasswordTextFieldView {
            _ = confirmPasswordTextFieldView.validate()
        }
    }
}
