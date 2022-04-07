//
//  PasswordCriteriaTests.swift
//  PasswordComponentTests
//
//  Created by Gizem Boskan on 7.04.2022.
//

import Foundation
import XCTest

@testable import PasswordComponent

class PasswordLenghtCriteriaTests: XCTestCase {
    
    // Tests for lengthCriteriaMet
    // Boundary conditions 8-32
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }
    
    func testLong() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123456781234567812345678123456781"))
    }
    
    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }
    
    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678123456781234567812345678"))
    }
}


class PasswordOtherCriteriaTests: XCTestCase {
    
    // Tests for noSpaceCriteriaMet
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("1234567"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("12345 67"))
    }
    
    // Tests for lengthAndNoSpaceCriteriaMet
    func testLengthAndNoSpaceMet() throws {
        // Boundary conditions 8
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceCriteriaMet("12345678"))
        
        // Boundary conditions 32
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceCriteriaMet("12345678123456781234567812345678"))
    }
    
    func testLengthAndNoSpaceNotMet() throws {
        // Boundary conditions 8
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceCriteriaMet("1234567"))
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceCriteriaMet("1234 5678"))
        
        // Boundary conditions 32
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceCriteriaMet("123456781234567812345678123456781"))
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceCriteriaMet("1234 5678123456781234567812345678"))
    }
    
    // Tests for uppercaseMet
    func testUppercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("1234567A"))
    }
    
    func testUppercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("1234567a"))
    }
    
    // Tests for lowercaseMet
    func testLowercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("1234567a"))
    }
    
    func testLowercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("12345A67"))
    }
    
    // Tests for digitMet
    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("1234567"))
    }
    
    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("abcd"))
    }
    
    // Tests for specialCharacterMet
    func testSpecialCharacterMet() throws {
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("1@234567"))
    }
    
    func testSpecialCharacterNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("123467"))
    }
}
