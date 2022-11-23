//
//  ViewController.swift
//  Task 11.5 Calculator
//
//  Created by Alibek Kozhambekov on 07.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var isNewValue = true
    var operation: MathOperation? = nil
    var previousOperation: MathOperation? = nil
    var result: Int = 0
    var newValue: Int = 0
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func zeroButton(_ sender: UIButton) {
        addDigit("0")
    }
    @IBAction func oneButton(_ sender: UIButton) {
        addDigit("1")
    }
    @IBAction func twoButton(_ sender: UIButton) {
        addDigit("2")
    }
    @IBAction func threeButton(_ sender: UIButton) {
        addDigit("3")
    }
    @IBAction func fourButton(_ sender: UIButton) {
        addDigit("4")
    }
    @IBAction func fiveButton(_ sender: UIButton) {
        addDigit("5")
    }
    @IBAction func sixButton(_ sender: UIButton) {
        addDigit("6")
    }
    @IBAction func sevenButton(_ sender: UIButton) {
        addDigit("7")
    }
    @IBAction func eightButton(_ sender: UIButton) {
        addDigit("8")
    }
    @IBAction func nineButton(_ sender: UIButton) {
        addDigit("9")
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        operation = .sum
        previousOperation = nil
        isNewValue = true
        result = getInteger()
    }
    @IBAction func minusButton(_ sender: UIButton) {
        operation = .substract
        previousOperation = nil
        isNewValue = true
        result = getInteger()
    }
    @IBAction func multiplyButton(_ sender: UIButton) {
        operation = .multiply
        previousOperation = nil
        isNewValue = true
        result = getInteger()
    }
    @IBAction func divideButton(_ sender: UIButton) {
        operation = .divide
        previousOperation = nil
        isNewValue = true
        result = getInteger()
    }
    @IBAction func equalButton(_ sender: UIButton) {
        calculate()
    }
    @IBAction func resetButton(_ sender: UIButton) {
        isNewValue = true
        result = 0
        newValue = 0
        operation = nil
        previousOperation = nil
        resultLabel.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = ConstantStrings.CalculatorTitle
    }
    
    func addDigit(_ digit: String) {
        if isNewValue {
            resultLabel.text = ""
            isNewValue = false
        }
        
        var digits = resultLabel.text
        digits?.append(digit)
        resultLabel.text = digits
    }
    
    func getInteger() -> Int {
        return Int(resultLabel.text ?? "0") ?? 0
    }
    
    func calculate() {
        
        guard let operation = operation else {
            return
        }
        
        if previousOperation != operation {
            newValue = getInteger()
        }
        
        do {
            result = try operation.makeOperation(result: result, newValue: newValue)
            resultLabel.text = "\(result)"
        } catch {
            resultLabel.text = error.localizedDescription
        }
        
        previousOperation = operation
        
        isNewValue = true
    }
    
    enum MathOperation: Error {
        case sum, substract, multiply, divide
        
        func makeOperation(result: Int, newValue: Int) throws -> Int {
            
            switch self {
            case .sum:
                return (result + newValue)
            case .substract:
                return (result - newValue)
            case .multiply:
                return (result * newValue)
            case .divide:
                guard newValue != 0 else {
                    throw ValidateError.dividedByZero
                }
                return (result / newValue)
            }
        }
    }
}

enum ValidateError: Error, LocalizedError {
    case dividedByZero
    
    var errorDescription: String? {
        
        var description = ""
        
        switch self {
        case .dividedByZero:
            description = "Error"
        }
        
        return description
    }
}
