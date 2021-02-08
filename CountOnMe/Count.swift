//
//  Count.swift
//  CountOnMe
//
//  Created by Stéphane Rihet on 22/01/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class Count {

    // MARK: - Properties

    /// This property  is an empty text for integrating a minus in the case of a decimal number.
    private var negativeString: String = ""
    /// This property  is a string with a property observer.
    var elementString: String {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Display"), object: nil)
        }
    }
    ///This property is a collection of text that is created from a string.
    private var elements: [String] {
        return elementString.split(separator: " ").map { "\($0)" }
    }
    /// Creates a empty String.
    init() {
        self.elementString = ""
    }

    // MARK: - functions

    ///Return a boolean after checking the first and last char of the collection.
    func expressionIsCorrect() -> Bool {
        return elements.last != "+"
            && elements.last != "-"
            && elements.last != "÷"
            && elements.last != "x"
            && elements.first != "x"
            && elements.first != "÷"
            && elements.first != "+"
    }

    ///Returns a boolean after checking the number of elements in the collection.
    func expressionHaveEnoughElement() -> Bool {
        return elements.count >= 3
    }

    ///Returns a boolean after verifying that the last character entered is not an operator.
    func canAddOperator() -> Bool {
        return elements.last != "+"
            && elements.last != "-"
            && elements.last != "÷"
            && elements.last != "x"
            && elementString.last != "."
    }

    ///Returns a boolean after verifying that the last ellemnts contains ".".
    func canAddPoint() -> Bool {
        let pointString: String = elements.last ?? ""
        if pointString.contains(".") {
            return false
        }
            return true
    }

    ///Returns a boolean after verifying that the collection contains an equal.
    func expressionHaveResult() -> Bool {
        return elements.contains("=")
    }

    /// Adds the number in elementString.
    ///
    /// Use this method to enter the number of the parameter after checking "expressionHaveResult()".
    ///
    ///- Parameter operators: The String of the button clicked.
    func addNumber(numbers: String) {
        if expressionHaveResult() {
            elementString = ""
        }
        elementString.append("\(negativeString)\(numbers)")
        negativeString = ""
    }

    /// Adds the minus in negativeString.
    ///
    /// Use this method to enter a negative number depending on the boolean received as a parameter.
    func addNegative(negative: Bool) {
        if negative == true {
            negativeString = "-"
        } else {
            negativeString = ""
        }
    }

    /// Adds the operator in elementString.
    ///
    /// Use this method to enter the operator of the parameter
    ///  in elementString or send a notification in case of error.
    ///
    ///- Parameter operators: The String of the button clicked.
    func addOperator(operators: String) {
        if canAddOperator() {
            switch operators {
            case ".":
                if canAddPoint() {
                    elementString.append("\(operators)")
                }
            default:
                elementString.append(" \(operators) ")
            }
        } else {
            switch operators {
            case ".":
                // swiftlint:disable:next line_length
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enterCorrectExpression"), object: nil)
            default:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "incorrectExpression"), object: nil)
            }
        }
    }

    /// Reset elementString.
    func reset() {
        elementString.removeAll()
    }

    /// After Cheking, Calculateby following the different rules.
    ///
    /// Use this method to perform the different calculations
    /// depending on the content of the collection and the mathematical priorities.
    func equal() {
        guard expressionIsCorrect() else {
            // swiftlint:disable:next line_length
            return NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enterCorrectExpression"), object: nil)
        }

        guard expressionHaveEnoughElement() else {
            // swiftlint:disable:next line_length
            return NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startNewCalculation"), object: nil)
        }

        // Create local copy of operations
        var operationsToReduce = elements
        // Checking the first number if negative
        if operationsToReduce[0] == "-" {
            operationsToReduce[0] = "\(operationsToReduce[0])\(operationsToReduce[1])"
            operationsToReduce.remove(at: 1)
        }
        //prioritization of calculations (Multiplication / Division)
        while operationsToReduce.contains("x") || operationsToReduce.contains("÷") {
            guard let product = calculateMultiplicationAndDivision(operationsToReduce: operationsToReduce) else {
                return
            }
            operationsToReduce = product
        }
        //End the calculation by non-priority calculations
        while operationsToReduce.count > 1 {
            guard let sum = calculateAdditionAndSubstraction(operationsToReduce: operationsToReduce) else {
                return
            }
            operationsToReduce = sum
        }
        guard let result = operationsToReduce.first else { return }
        elementString.append(" = \(result)")
    }

    /// Returns a collection with the result of the computation performed.
    ///
    ///Use this method to find the operator (multiplication or division) index in order to call the function calculate.
    ///
    ///- Parameter operationsToReduce:The character chain collection.
    func calculateMultiplicationAndDivision(operationsToReduce: [String]) -> [String]? {
        var calculatePriority = operationsToReduce
        if let indexOfOperator = calculatePriority.firstIndex(where: { $0 == "x" || $0 == "÷"}) {
            let calculateResult = calculate(index: indexOfOperator, calculate: calculatePriority)
            calculatePriority = calculateResult ?? [""]
        }
        return calculatePriority
    }

    /// Returns a collection with the result of the computation performed.
    ///
    ///Use this method to find the operator (Addition or Substraction) index in order to call the function calculate.
    ///
    ///- Parameter operationsToReduce:The String collection.
    func calculateAdditionAndSubstraction(operationsToReduce: [String]) -> [String]? {
        var calculateAddSubs = operationsToReduce
        if let indexOfOperator = calculateAddSubs.firstIndex(where: { $0 == "+" || $0 == "-"}) {
            let calculateResult = calculate(index: indexOfOperator, calculate: calculateAddSubs)
            calculateAddSubs = calculateResult ?? [""]
        }
        return calculateAddSubs
    }

    /// Calculate according to the operator's index.
    ///
    /// Use this method for each sub-calculation found in the collection
    /// in order to replace the three characters with the result of the calculation.
    ///
    ///- Parameter index:The operator's index.
    ///- Parameter calculate:The String collection.
    func calculate(index: Int, calculate: [String]) -> [String]? {
        var calculateResult = calculate
        guard let left = Float(calculateResult[index - 1]) else {
            return nil
        }
        let operand = calculateResult[index]
        guard let right = Float(calculateResult[index + 1]) else {
            return nil
        }

        let result: Float

        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "÷": if right == 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "divisionbByZero"), object: nil)
            return nil
        }
        result = left / right

        case "x": result = left * right
        default: fatalError("Unknown operator !")
        }

        calculateResult[index - 1] = "\(displayNumber(number: result))"
        calculateResult.remove(at: index + 1)
        calculateResult.remove(at: index)

        return calculateResult
    }

    /// Remove a decimal from a float if the decimal is equal to 0.
    ///
    ///- Parameter number: The result of the caculate.
    internal func displayNumber(number: Float) -> Any {
        if number - Float(Int(number)) == 0 {
            return Int(number)
        } else {
            return number
        }
    }
}
