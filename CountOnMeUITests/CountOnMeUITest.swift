//
//  CountOnMeUITest.swift
//  CountOnMeUITests
//
//  Created by Stéphane Rihet on 26/01/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest

class CountOnMeUITest: XCTestCase {

    private let app = XCUIApplication() // Stock a proxy for an application that can be launched and terminated.
    private var textViewString: String?

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTheUserInterface_WhenAnOperation_ThenDisplayInTextView() {
        app.buttons["+/-"].tap()
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["x"].tap()
        app.buttons["5"].tap()
        app.buttons["3"].tap()
        app.buttons["-"].tap()
        app.buttons["5"].tap()
        app.buttons["x"].tap()
        app.buttons["+/-"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        textViewString = app.textViews["TextViewCount"].value as? String

        XCTAssertEqual(textViewString, "-5 + 6 ÷ 2 x 53 - 5 x -6 = 184")
    }

    func testTheUserInterface_WhenAnDecimalOperation_ThenDisplayInTextView() {
        app.buttons["+/-"].tap()
        app.buttons["5"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        textViewString = app.textViews["TextViewCount"].value as? String

        XCTAssertEqual(textViewString, "-5.5 + 6 = 0.5")
    }

    func testTheUserInterface_WhenAddNegativeButton_ThenDisplayInTextView() {

        app.buttons["+/-"].tap()
        app.buttons["+/-"].tap()
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        textViewString = app.textViews["TextViewCount"].value as? String

        XCTAssertEqual(textViewString, "5 + 6 = 11")
    }

    func testTheUserInterface_WhenACButton_ThenDisplayInTextView() {
        app.buttons["-"].tap()
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        textViewString = app.textViews["TextViewCount"].value as? String

        XCTAssertEqual(textViewString, " - 5 + 6 = 1")

        app.buttons["AC"].tap()
        textViewString = app.textViews["TextViewCount"].value as? String

        XCTAssertEqual(textViewString, "")
    }

    func testTheUserInterface_WhenIncorrectExpression_ThenDisplayAlert() {
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["x"].tap()

        XCTAssertTrue(app.alerts["Zéro!"].isHittable)
    }

    func testTheUserInterface_WhenEnterCorrectExpression_ThenDisplayAlert() {
        app.buttons["5"].tap()
        app.buttons["x"].tap()
        app.buttons["="].tap()

        XCTAssertTrue(app.alerts["Zéro!"].isHittable)
    }

    func testTheUserInterface_WhenStartNewCalculation_ThenDisplayAlert() {
        app.buttons["5"].tap()
        app.buttons["="].tap()

        XCTAssertTrue(app.alerts["Zéro!"].isHittable)
    }

    func testTheUserInterface_WhenDivisionbByZero_ThenDisplayAlert() {
        app.buttons["5"].tap()
        app.buttons["÷"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()

        XCTAssertTrue(app.alerts["Zéro!"].isHittable)
    }

    func testTheUserInterface_WhenDoublePointButton_ThenDisplayAlert() {
        app.buttons["5"].tap()
        app.buttons["."].tap()
        app.buttons["."].tap()

        XCTAssertTrue(app.alerts["Zéro!"].isHittable)
    }
        }
