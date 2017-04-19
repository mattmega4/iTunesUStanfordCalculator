//
//  ViewController.swift
//  ItunesUStandfordCalculator
//
//  Created by Matthew Singleton on 4/18/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var display: UILabel!
  
  private var brain = CalculatorBrain()
  
  var userIsInTheMiddleOfTyping = false
  
  var displayValue: Double {
    get {
      return Double(display.text!)!
    }
    set {
      display.text = String(newValue)
    }
  }
  
  @IBAction func touchDigit(_ sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTyping {
      let textCurrentlyInDisplay = display.text!
      display.text = textCurrentlyInDisplay + digit
    } else {
      display.text = digit
      userIsInTheMiddleOfTyping = true
    }
  }
  
  @IBAction func performOperation(_ sender: UIButton) {
    if userIsInTheMiddleOfTyping {
      brain.setOperand(displayValue)
      userIsInTheMiddleOfTyping = false
    }
    
    if let mathmaticalSymbol = sender.currentTitle {
      brain.performOperation(mathmaticalSymbol)
    }
    
    if let result = brain.result {
      displayValue = NSNumber(value: result).doubleValue
    }
  }
  
  
}

