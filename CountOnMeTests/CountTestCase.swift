//
//  CountTestCase.swift
//  CountOnMeTests
//
//  Created by Stéphane Rihet on 25/01/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountTestCase: XCTestCase {

    var count: Count!

    override func setUp() {
        super.setUp()
        count = Count()
    }

    func testGivenTheLastElementIsOperator_WhenTestingExpressionIsCorrect_ThenTheResultMustBeFalse() {
        count.elementString = "22 +"
        XCTAssertFalse(count.expressionIsCorrect())
        count.elementString = "65 + 2 -"
        XCTAssertFalse(count.expressionIsCorrect())
        count.elementString = "22 x"
        XCTAssertFalse(count.expressionIsCorrect())
        count.elementString = "22 ÷ 6 ÷"
        XCTAssertFalse(count.expressionIsCorrect())
    }

    func testGivenTheLastElementIsNotOperator_WhenTestingExpressionIsCorrect_ThenTheResultMustBeTrue() {
        count.elementString = "22 + 16"
        XCTAssertTrue(count.expressionIsCorrect())
        count.elementString = "65 + 2 - 5"
        XCTAssertTrue(count.expressionIsCorrect())
        count.elementString = "22 x 32"
        XCTAssertTrue(count.expressionIsCorrect())
        count.elementString = "22 ÷ 6 ÷ 9"
        XCTAssertTrue(count.expressionIsCorrect())
    }

    func testGivenDifferentNumberOfElement_WhenTestingExpressionHaveEnoughtElement_ThenTheResultIsFalse() {
        count.elementString = "2 ="
        XCTAssertFalse(count.expressionHaveEnoughElement())
        count.elementString = "2"
        XCTAssertFalse(count.expressionHaveEnoughElement())
    }

    func testGivenDifferentNumberOfElement_WhenTestingExpressionHaveEnoughtElement_ThenTheResultIsTrue() {
        count.elementString = "34 + 21 "
        XCTAssertTrue(count.expressionHaveEnoughElement())
        count.elementString = "34 + 21 ="
        XCTAssertTrue(count.expressionHaveEnoughElement())
    }

    func testGivenElementIsEqual_WhenTestingExpressionResult_ThenTheResultIsTrue() {
        count.elementString = "= "
        XCTAssertTrue(count.expressionHaveResult())

    }

    func testGivenNegativeIsFalse_WhenTestingAddNegative_ThenTheResultIsEmpty() {
        count.addNegative(negative: false)
        XCTAssertEqual(count.elementString, "")
    }

    func testGivenTheLastElementIsOperator_WhenTestingcanAddOperator_ThenTheResultIsFalse() {
        count.elementString = "45 + "
        XCTAssertFalse(count.canAddOperator())
        count.elementString = "9 - "
        XCTAssertFalse(count.canAddOperator())
        count.elementString = "14 ÷ "
        XCTAssertFalse(count.canAddOperator())
        count.elementString = "76 x "
        XCTAssertFalse(count.canAddOperator())
        count.elementString = "76."
        XCTAssertFalse(count.canAddOperator())
    }

    func testGivenTheLastElementIsOperator_WhenTestingcanAddPoint_ThenTheResultIsFalse() {
        count.elementString = "45.5 "
        XCTAssertFalse(count.canAddPoint())
    }

    func testGivenTheExpressionContainsEqual_WhenTestingExpressionHaveResult_ThenThenTheResultMustBeTrue() {
        count.elementString = "22 45 = "
        XCTAssertTrue(count.expressionHaveResult())
        count.elementString = "22 = "
        XCTAssertTrue(count.expressionHaveResult())
    }

    func testGivenTheExpressionDontContainsEqual_WhenTestingExpressionHaveResult_ThenThenTheResultMustBeFalse() {
        count.elementString = "3 32 7 "
        XCTAssertFalse(count.expressionHaveResult())
    }

    func testGivenElementsAre1253Plus751_WhenTestingCalculateAdditionAndSubstraction_ThenTheResultIs2004() {
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["1253", "+", "751"]), ["2004"])
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["751", "+", "1253"]), ["2004"])
    }

    func testGivenElementsAre1258Less325_WhenTestingCalculateAdditionAndSubstraction_ThenTheResultIs933() {
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["1258", "-", "325"]), ["933"])
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["933", "+", "325"]), ["1258"])
    }

    func testGivenElementsAre1253Plus751_WhenTestingEqualFunction_ThenTheResultIs2004() {
        count.elementString = "1253 + 751"
        count.equal()
        XCTAssertEqual(count.elementString, "1253 + 751 = 2004")
    }

    func testGivenElementsAre1258Less325_WhenTestingEqualFunction_ThenTheResultIs933() {
        count.elementString = "1258 - 325"
        count.equal()
        XCTAssertEqual(count.elementString, "1258 - 325 = 933")
    }

    func testGivenElementsAre125Multiplicated32_WhenTestingCalculateMultiplicationAndDivision_ThenTheResultIs4000() {
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["125", "x", "32"]), ["4000"])
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["32", "x", "125"]), ["4000"])
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["4000", "÷", "32"]), ["125"])
    }

    func testGivenElementsAre480Divised15_WhenTestingCalculateMultiplicationAndDivision_ThenTheResultIs32() {
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["480", "÷", "15"]), ["32"])
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["15", "x", "32"]), ["480"])
    }

    func testGivenCalculationIsFinish_WhenTestingAddNumber_ThenExpressionHaveResult() {
        count.elementString = "25 x 2 = 50"
        count.addNumber(numbers: "32")
        XCTAssertEqual(count.elementString, "32")
    }
    func testGivenElementsAre125Multiplicated32_WhenTestingEqualFunction_ThenTheResultIs4000() {
        count.addNumber(numbers: "125")
        count.addOperator(operators: "x")
        count.addNumber(numbers: "32")
        count.equal()
        XCTAssertEqual(count.elementString, "125 x 32 = 4000")
    }

    func testGivenElementsAre480Divised15_WhenTestingEqualFunction_ThenTheResultIs32() {
        count.elementString = "480 ÷ 15"
        count.equal()
        XCTAssertEqual(count.elementString, "480 ÷ 15 = 32")
    }

    func testGivenFirstElementIsNegative_WhenTestingEqualFunction_ThenTheResultIsOk() {
        count.addNegative(negative: true)
        count.addNumber(numbers: "48")
        count.addOperator(operators: "÷")
        count.addNumber(numbers: "15")
        count.equal()
        XCTAssertEqual(count.elementString, "-48 ÷ 15 = -3.2")
    }

    func testGivenFirstElementIsMinus_WhenTestingEqualFunction_ThenTheResultIsOk() {
        count.addOperator(operators: "-")
        count.addNumber(numbers: "48")
        count.addOperator(operators: "÷")
        count.addNumber(numbers: "15")
        count.equal()
        XCTAssertEqual(count.elementString, " - 48 ÷ 15 = -3.2")
    }

    func testGiven_WhenTestingAddOperatorFunction_ThenTheResultIsOk() {
        count.addOperator(operators: "-")
        count.addNumber(numbers: "48")
        count.addOperator(operators: "÷")
        count.addNumber(numbers: "15")
        count.equal()
        XCTAssertEqual(count.elementString, " - 48 ÷ 15 = -3.2")
    }

    func testGivenTheDivisionByZero_WhenTestingCalculateMultiplicationAndDivision_ThenTheResultIsEmpty() {
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["480", "÷", "0"]), [""])
    }

    func testGivenAllElementIsOperator_WhenTestingCalculateMultiplicationAndDivision_ThenTheResultIsEmpty() {
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["-", "÷", "10"]), [""])
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["10", "x", "+"]), [""])
    }

    func testGivenAllElementIsOperator_WhenTestingCalculateAdditionAndSubstraction_ThenTheResultIsEmpty() {
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["x", "+", "10"]), [""])
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["10", "-", "÷"]), [""])
    }

    func testGivenAllElementIsOperator_WhenTestingCalculateMultiplicationAndDivision_ThenTheResultIsNil() {
        XCTAssertNil(count.calculate(index: 1, calculate: ["x", "+", "10"]))
        XCTAssertNil(count.calculate(index: 1, calculate: ["10", "-", "÷"]))
        XCTAssertNil(count.calculate(index: 1, calculate: ["+", "x", "10"]))
        XCTAssertNil(count.calculate(index: 1, calculate: ["10", "÷", "-"]))
    }

    func testGivenCalculationPriorityIsEssential_WhenTestingEqualFunction_ThenTheResultIsOk() {
        count.elementString = "-48 ÷ 15 + 5"
        count.equal()
        XCTAssertEqual(count.elementString, "-48 ÷ 15 + 5 = 1.8")
        count.elementString = "10 + 3 x -4 - 2 ÷ 8"
        count.equal()
        XCTAssertEqual(count.elementString, "10 + 3 x -4 - 2 ÷ 8 = -2.25")
    }

    func testGivenElementsAre125Multiplicated32_WhenResetFunction_ThenElementIsEmpty() {
        count.elementString = "125 x 32"
        count.equal()
        XCTAssertEqual(count.elementString, "125 x 32 = 4000")
        count.reset()
        XCTAssertEqual(count.elementString, "")
    }
}
