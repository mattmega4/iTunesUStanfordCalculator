//
//  CalculatorBrain.swift
//  ItunesUStandfordCalculator
//
//  Created by Matthew Singleton on 4/18/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import Foundation

struct CalculatorBrain {
  
  private var accumulator: Double?
  private var pendingBinaryOperation: PendingBinaryOperation?
  
  private enum Operation {
    case constant(Double)
    case unaryOperation((Double) -> Double)
    case binaryOperation((Double, Double) -> Double)
    case equals
    case clear
  }
  
  private var operations: Dictionary<String, Operation> = [
    //    "π" : Operation.constant(Double.pi),
    //    "e" : Operation.constant(M_E),
    //    "": Operation.unaryOperation(sqrt),
    //    "" : Operation.unaryOperation(cos),
    "+/−" : Operation.unaryOperation({ -$0 }),
    "×" : Operation.binaryOperation({ $0 * $1 }),
    "÷" : Operation.binaryOperation({ $0 / $1 }),
    "+" : Operation.binaryOperation({ $0 + $1 }),
    "−" : Operation.binaryOperation({ $0 - $1 }),
    //    "%" : Operation.binaryOperation({ ? }),
    "=" : Operation.equals,
    "AC" : Operation.clear
  ]
  
  
  
  mutating func performOperation(_ symbol: String) {
    if let operation = operations[symbol] {
      switch operation {
      case .constant(let value):
        accumulator = value
      case .unaryOperation(let function):
        if accumulator != nil {
          accumulator = function(accumulator!)
        }
      case .binaryOperation(let function):
        if accumulator != nil {
          pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
          accumulator = nil
        }
      case .equals:
        performPendingBinaryOperation()
      case .clear:
        clearAll()
      }
    }
  }
  
  
  private mutating func performPendingBinaryOperation() {
    if pendingBinaryOperation != nil && accumulator != nil {
      accumulator = NSNumber(value: pendingBinaryOperation!.perform(with: accumulator!)).doubleValue
      pendingBinaryOperation = nil
    }
  }
  
  //
  private mutating func clearAll() {
    accumulator = 0
    pendingBinaryOperation = nil
  }
  
  private func checkIfWholeNumber(displayedDouble: Double) -> Double {
    let cleanDouble = NSNumber(value: displayedDouble).doubleValue
    return cleanDouble
  }
  //
  
  
  private struct PendingBinaryOperation {
    let function: (Double, Double) -> Double
    let firstOperand: Double
    
    func perform(with secondOperand: Double) -> Double {
      return function(firstOperand, secondOperand)
    }
  }
  
  mutating func setOperand(_ operand: Double) {
    accumulator = operand
  }
  
  var result: Double? {
    get {
      return accumulator?)
    }
  }
}
