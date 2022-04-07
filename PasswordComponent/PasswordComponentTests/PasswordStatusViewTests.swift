//
//  PasswordStatusViewTests.swift
//  PasswordComponentTests
//
//  Created by Gizem Boskan on 7.04.2022.
//

import Foundation
import XCTest

@testable import PasswordComponent

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {
    
    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true // inline
    }
    
    // Inline validation for ✅ or ❌
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }
    
    func testTooShortPassword() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertFalse(statusView.lengthCriteriaView.isXmarkImage)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage)
    }
}

class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {
    
    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false // loss of focus
    }
    
    // focus lost (✅ or ❌)
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
        XCTAssertFalse(statusView.lengthCriteriaView.isResetImage)
        
    }
    
    func testTooShortPassword() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage)
        XCTAssertFalse(statusView.lengthCriteriaView.isResetImage)
    }
}

class PasswordStatusViewTests_Validations_For_Criteria_Of_Three_Of_Four: XCTestCase {
    
    var statusView: PasswordStatusView!
    let twoOfFour = "12345678A"
    let threeOfFour = "12345678Aa"
    let fourOfFour = "12345678Aa!"
    let sufficentCriteriaPassword = "12345678Aa!"
    let insufficentCriteriaPassword = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }
    
    // Verify is valid if 3 of 4 criteria met
    // Boundary conditions threeOfFour
    func testForSufficentCriteriaPassword() throws {
        XCTAssertTrue(statusView.validate(threeOfFour))
        XCTAssertTrue(statusView.validate(fourOfFour))
        XCTAssertTrue(statusView.validate(sufficentCriteriaPassword))
    }
    
    // Boundary conditions twoOfFour
    func testForInsufficentCriteriaPassword() throws {
        XCTAssertFalse(statusView.validate(twoOfFour))
        XCTAssertFalse(statusView.validate(insufficentCriteriaPassword))
    }
}
