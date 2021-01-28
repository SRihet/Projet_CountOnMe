//
//  Count.swift
//  CountOnMe
//
//  Created by Stéphane Rihet on 22/01/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Count {
    // Error check computed variables
    //retourne true si un des opérateurs est le dernier dans la collections
    func expressionIsCorrect(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x" && elements.first != "x" && elements.first != "÷" && elements.first != "+"
    }
    
    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }
    
    func canAddOperator(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }
    
    func expressionHaveResult(elements: [String]) -> Bool {
        return elements.firstIndex(of: "=") != nil
    }
    
    
    func equal(elements: [String]) -> String! {
        // Create local copy of operations
        var operationsToReduce = elements
        
        if operationsToReduce[0] == "-" {
            operationsToReduce[0] = "\(operationsToReduce[0])\(operationsToReduce[1])"
            operationsToReduce.remove(at: 1)
        }
        
        while operationsToReduce.contains("x") || operationsToReduce.contains("÷"){
            print("\(operationsToReduce) before prio")
            guard let product = calculateMultiplicationAndDivision(operationsToReduce: operationsToReduce) else {
                return nil
            }
            operationsToReduce = product
            print("\(operationsToReduce)  after prio")
        }
        
        while operationsToReduce.count > 1 {
            print("\(operationsToReduce) before addsub")
            guard let sum = calculateAdditionAndSubstraction(operationsToReduce: operationsToReduce) else {
                return nil
            }
            operationsToReduce = sum
            print("\(operationsToReduce) before addsub")
        }

        return operationsToReduce.first
    }
    
    func calculateMultiplicationAndDivision(operationsToReduce:[String]) -> [String]? {
        // realiser le calcul et remplacer les 3 index en 1 seul
        var calculatePriority = operationsToReduce
        if let indexOfOperator = calculatePriority.firstIndex(where: { $0 == "x" || $0 == "÷"}) {
            guard let left = Float(calculatePriority[indexOfOperator - 1])else {
                return nil
            }
        let operand = calculatePriority[indexOfOperator]
            guard let right = Float(calculatePriority[indexOfOperator + 1])else {
                return nil
            }
        
        let result: Float
        
        switch operand {
        case "÷": if right == 0 {
            return nil
        }
            result = left / right
            
        case "x": result = left * right
        default: fatalError("Unknown operator !")
        }
        
        calculatePriority[indexOfOperator - 1] = "\(displayNumber(number: result))"
        calculatePriority.remove(at: indexOfOperator + 1)
        calculatePriority.remove(at: indexOfOperator)
        
        
        }
        return calculatePriority
    }
    
    func calculateAdditionAndSubstraction(operationsToReduce:[String]) -> [String]? {
        var calculateAddSubs = operationsToReduce
        if let indexOfOperator = calculateAddSubs.firstIndex(where: { $0 == "+" || $0 == "-"}) {
            guard let left = Float(calculateAddSubs[indexOfOperator - 1]) else {
                return nil
            }
        let operand = calculateAddSubs[indexOfOperator]
            guard let right = Float(calculateAddSubs[indexOfOperator + 1]) else {
                return nil
            }
        
        let result: Float
        
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        default: fatalError("Unknown operator !")
        }
        
        calculateAddSubs[indexOfOperator - 1] = "\(displayNumber(number: result))"
        calculateAddSubs.remove(at: indexOfOperator + 1)
        calculateAddSubs.remove(at: indexOfOperator)
        
        }
        return calculateAddSubs
    }
    
    //remove a decimal from a float if the decimal is equal to 0
    func displayNumber(number: Float) -> Any {
        if number - Float(Int(number)) == 0 {
            return Int(number)
        } else {
            return number
        }
    }
    
    
    
}

