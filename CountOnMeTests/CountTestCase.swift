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
    
    func testGivenTheLastElementIsOperator_WhenTestingExpressionIsCorrect_ThenTheResultMustBeFalse()  {
        XCTAssertFalse(count.expressionIsCorrect(elements: ["22", "45", "+"]))
        XCTAssertFalse(count.expressionIsCorrect(elements: ["65", "9", "-"]))
        XCTAssertFalse(count.expressionIsCorrect(elements: ["3", "14", "÷"]))
        XCTAssertFalse(count.expressionIsCorrect(elements: ["1", "76", "x"]))
    }
    func testGivenTheLastElementIsNotOperator_WhenTestingExpressionIsCorrect_ThenTheResultMustBeTrue()  {
        XCTAssertTrue(count.expressionIsCorrect(elements: ["22", "45", "4"]))
        XCTAssertTrue(count.expressionIsCorrect(elements: ["=", "9", "34"]))
        XCTAssertTrue(count.expressionIsCorrect(elements: ["3", "+", "9"]))
    }
    
    func testGivenDifferentNumberOfElement_WhenTestingExpressionHaveEnoughtElement_ThenTheResultIsFalse() {
        XCTAssertFalse(count.expressionHaveEnoughElement(elements: ["2", "="]))
        XCTAssertFalse(count.expressionHaveEnoughElement(elements: ["2"]))
    }
    
    func testGivenDifferentNumberOfElement_WhenTestingExpressionHaveEnoughtElement_ThenTheResultIsTrue() {
        XCTAssertTrue(count.expressionHaveEnoughElement(elements: ["34","+", "21"]))
        XCTAssertTrue(count.expressionHaveEnoughElement(elements: ["34","+", "21", "="]))
    }
    
    func testGivenTheLastElementIsOperator_WhenTestingcanAddOperator_ThenTheResultIsFalse()  {
        XCTAssertFalse(count.canAddOperator(elements: ["22", "45", "+"]))
        XCTAssertFalse(count.canAddOperator(elements: ["65", "9", "-"]))
        XCTAssertFalse(count.canAddOperator(elements: ["3", "14", "÷"]))
        XCTAssertFalse(count.canAddOperator(elements: ["1", "76", "x"]))
    }
    
    func testGivenTheExpressionContainsEqual_WhenTestingExpressionHaveResult_ThenThenTheResultMustBeTrue() {
        XCTAssertTrue(count.expressionHaveResult(elements: ["3","32","="]))
        XCTAssertTrue(count.expressionHaveResult(elements: ["3","="]))
    }
    
    func testGivenTheExpressionDontContainsEqual_WhenTestingExpressionHaveResult_ThenThenTheResultMustBeFalse() {
        XCTAssertFalse(count.expressionHaveResult(elements: ["3","32","7"]))
    }
    
    
    func testGivenElementsAre1253Plus751_WhenTestingCalculateAdditionAndSubstraction_ThenTheResultIs2004() {
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["1253","+","751"]), ["2004"])
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["751","+","1253"]), ["2004"])
    }
    
    func testGivenElementsAre1258Less325_WhenTestingCalculateAdditionAndSubstraction_ThenTheResultIs933() {
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["1258","-","325"]), ["933"])
        XCTAssertEqual(count.calculateAdditionAndSubstraction(operationsToReduce: ["933","+","325"]), ["1258"])
    }
    
    func testGivenElementsAre1253Plus751_WhenTestingEqualFunction_ThenTheResultIs2004() {
        XCTAssertEqual(count.equal(elements: ["1253","+","751"]), "2004")
        XCTAssertEqual(count.equal(elements: ["751","+","1253"]), "2004")
    }
    
    func testGivenElementsAre1258Less325_WhenTestingEqualFunction_ThenTheResultIs933() {
        XCTAssertEqual(count.equal(elements: ["1258","-","325"]), "933")
        XCTAssertEqual(count.equal(elements: ["933","+","325"]), "1258")
    }
    
    func testGivenElementsAre125Multiplicated32_WhenTestingCalculateMultiplicationAndDivision_ThenTheResultIs4000() {
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["125","x","32"]), ["4000"])
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["32","x","125"]), ["4000"])
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["4000","÷","32"]), ["125"])
    }
    
    func testGivenElementsAre480Divised15_WhenTestingCalculateMultiplicationAndDivision_ThenTheResultIs32() {
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["480","÷","15"]), ["32"])
        XCTAssertEqual(count.calculateMultiplicationAndDivision(operationsToReduce: ["15","x","32"]), ["480"])

    }
    
    func testGivenElementsAre125Multiplicated32_WhenTestingEqualFunction_ThenTheResultIs4000() {        XCTAssertEqual(count.equal(elements: ["125","x","32"]), "4000")
        XCTAssertEqual(count.equal(elements: ["32","x","125"]), "4000")
        XCTAssertEqual(count.equal(elements: ["4000","÷","32"]), "125")
    }
    
    func testGivenElementsAre480Divised15_WhenTestingEqualFunction_ThenTheResultIs32() {
        XCTAssertEqual(count.equal(elements: ["480","÷","15"]), "32")
        XCTAssertEqual(count.equal(elements: ["15","x","32"]), "480")
    }
    
    func testGivenFirstElementIsNegative_WhenTestingEqualFunction_ThenTheResultIsOk() {
        XCTAssertEqual(count.equal(elements: ["-48","÷","15"]), "-3.2")
        XCTAssertEqual(count.equal(elements: ["-48","x","15"]), "-720")
        XCTAssertEqual(count.equal(elements: ["-48","+","15"]), "-33")
        XCTAssertEqual(count.equal(elements: ["-48","-","15"]), "-63")
        XCTAssertEqual(count.equal(elements: ["-","48","÷","15"]), "-3.2")
        XCTAssertEqual(count.equal(elements: ["-","48","x","15"]), "-720")
        XCTAssertEqual(count.equal(elements: ["-","48","+","15"]), "-33")
        XCTAssertEqual(count.equal(elements: ["-","48","-","15"]), "-63")
    }
    
    func testGivenTheDivisionByZero_WhenTestingCalculateMultiplicationAndDivision_ThenTheResultIsNil() {
        XCTAssertNil(count.calculateMultiplicationAndDivision(operationsToReduce: ["480","÷","0"]))
    }
    
    func testGivenTheDivisionByZero_WhenTestingEqual_ThenTheResultIsNil() {
        XCTAssertNil(count.equal(elements: ["480","÷","0"]))
    }
    
    func testGivenAllElementIsOperator_WhenTestingCalculateMultiplicationAndDivision_ThenTheResultIsNil() {
        XCTAssertNil(count.calculateMultiplicationAndDivision(operationsToReduce: ["-","÷","10"]))
        XCTAssertNil(count.calculateMultiplicationAndDivision(operationsToReduce: ["10","x","+"]))
    }
    
    func testGivenAllElementIsOperator_WhenTestingCalculateAdditionAndSubstraction_ThenTheResultIsNil() {
        XCTAssertNil(count.calculateAdditionAndSubstraction(operationsToReduce: ["x","+","10"]))
        XCTAssertNil(count.calculateAdditionAndSubstraction(operationsToReduce: ["10","-","÷"]))
    }
    
    func testGivenAllElementIsWrong_WhenTestingEqual_ThenTheResultIsNil() {
        XCTAssertNil(count.equal(elements: ["p","+","10"]))
        XCTAssertNil(count.equal(elements: ["10","-","q"]))
        
    }
    
    func testGivenCalculationPriorityIsEssential_WhenTestingEqualFunction_ThenTheResultIsOk() {
        XCTAssertEqual(count.equal(elements: ["-48","÷","15","+","5"]), "1.8")
        XCTAssertEqual(count.equal(elements: ["2","+","5","x","4"]), "22")
        XCTAssertEqual(count.equal(elements: ["10","+","3","x","-4","-","2","÷","8"]), "-2.25")
        
    }
    

    
}
