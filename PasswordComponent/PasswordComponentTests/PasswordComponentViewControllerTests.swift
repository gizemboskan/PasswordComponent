//
//  PasswordComponentViewControllerTests.swift
//  PasswordComponentTests
//
//  Created by Gizem Boskan on 7.04.2022.
//

import Foundation
import XCTest

@testable import PasswordComponent

class PasswordComponentViewControllerTests_NewPassword_Validation: XCTestCase {
    
    var vc: PasswordComponentViewController!
    let validPassword = "12345678aA!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = PasswordComponentViewController()
    }
    
    /*
     Here we trigger those criteria blocks by entering text,
     clicking the reset password button, and then checking
     the error label text for the right message.
     */
    
    // Empty Text
    func testEmptyPassword() throws {
        vc.newPaswordText = ""
        vc.resetButtonTapped()
        
        XCTAssertEqual(vc.newPasswordTextFieldView.errorLabel.text, "Enter your password")
    }
    
    // Invalid Characters
    func testInvalidCharactersInPassword() throws {
        vc.newPaswordText = "ab<>"
        vc.resetButtonTapped()
        
        XCTAssertEqual(vc.newPasswordTextFieldView.errorLabel.text, "Enter valid special chars (.,@:?!()$#\\/) with no spaces.")
    }
    
    // Criteria Not Met
    func testCriteriaNotMetPassword() throws {
        vc.newPaswordText = tooShort
        vc.resetButtonTapped()
        
        XCTAssertEqual(vc.newPasswordTextFieldView.errorLabel.text, "Your password must meet the requirements below.")
    }
    
    // Criteria met
    func testCriteriaMetPassword() throws {
        vc.newPaswordText = validPassword
        vc.resetButtonTapped()
        
        XCTAssertEqual(vc.newPasswordTextFieldView.errorLabel.text, "")
    }
}

class PasswordComponentViewControllerTests_ConfirmPassword_Validation: XCTestCase {
    
    var vc: PasswordComponentViewController!
    let validPassword = "12345678aA!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = PasswordComponentViewController()
    }
    
    /*
     Here we trigger those criteria blocks by entering text,
     clicking the reset password button, and then checking
     the error label text for the right message.
     */
    
    // Empty Text
    func testEmptyPassword() throws {
        vc.confirmPasswordText = ""
        vc.resetButtonTapped()
        
        XCTAssertEqual(vc.confirmPasswordTextFieldView.errorLabel.text, "Enter your password")
    }
    
    // Passwords Not match
    func testNotMatchPassword() throws {
        vc.newPaswordText = validPassword
        vc.confirmPasswordText = tooShort
        vc.resetButtonTapped()
        
        XCTAssertEqual(vc.confirmPasswordTextFieldView.errorLabel.text, "Passwords do not match.")
    }
    
    // Passwords match
    func testMatchPassword() throws {
        vc.newPaswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetButtonTapped()
        
        XCTAssertEqual(vc.confirmPasswordTextFieldView.errorLabel.text, "")
    }
}

class PasswordComponentViewControllerTests_Show_Alert: XCTestCase {
    
    var vc: PasswordComponentViewController!
    let validPassword = "12345678aA!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = PasswordComponentViewController()
    }
    
    /*
     Here we trigger those criteria blocks by entering text,
     clicking the reset password button, and then checking
     the error label text for the right message.
     */
    
    // success alert
    func testShowSuccess() throws {
        vc.newPaswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetButtonTapped()
        
        XCTAssertNotNil(vc.alert)
        XCTAssertEqual(vc.alert!.title, "Success!") // Optional case. to reduce the coupling you can delete this! Coupling gives precise but fragile work!
    }
    
    // error alert (now it is nil)
    func testShowError() throws {
        vc.newPaswordText = validPassword
        vc.confirmPasswordText = tooShort
        vc.resetButtonTapped()
        
        XCTAssertNil(vc.alert)
    }
}
