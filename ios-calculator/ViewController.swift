//
//  ViewController.swift
//  ios-calculator
//
//  Created by Николай on 06.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var shouldClear: Bool = false
    private var shouldInsertDot: Bool = false
    private var sequenceOpTaps: Int = 0
    private var sequenceRetTaps: Int = 0
    private var expressionHandle: ExpressionHandle!
    private var unaryExpressionHandle: UnaryExpressionHandle!
    
    private var formatter: NumberFormatter!
    
    @IBOutlet weak var txtFiledResult: UITextField!
    @IBOutlet weak var txtFieldCurrent: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        expressionHandle = ExpressionHandle()
        unaryExpressionHandle = UnaryExpressionHandle()
        
        formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        
//        operationObject.addObserver(self, forKeyPath: "operationString", options: .new, context: nil)
//        txtFieldCurrent.addObserver(self, forKeyPath: "text", options: .new, context: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func performAction(_ sender: UIButton) {
        var identifier: String! = sender.accessibilityIdentifier
        if identifier != nil {
            
            if (identifier != "+" &&
                identifier != "-" &&
                identifier != "*" &&
                identifier != "/" &&
                identifier != "sin" &&
                identifier != "cos" &&
                identifier != "sign" &&
                identifier != "sqrt" &&
                identifier != "=")
            {
                sequenceOpTaps = 0
                sequenceRetTaps = 0
            }
            
            switch identifier {
            case "0"..."9":
                if shouldClear {
                    txtFieldCurrent.text = identifier
                    shouldClear = false
                    break
                }
                var currentNumber = txtFieldCurrent.text
                if currentNumber == nil || (currentNumber?.isEmpty)!{
                    if shouldInsertDot {
                        identifier = "0." + identifier
                        shouldInsertDot = false
                    }
                    txtFieldCurrent.text = identifier
                }
                else {
                    if shouldInsertDot {
                        if !(currentNumber?.contains("."))! {
                            identifier = "." + identifier
                        }
                        shouldInsertDot = false
                    }
                    currentNumber?.append(identifier)
                    txtFieldCurrent.text = currentNumber
                }
                unaryExpressionHandle.clear()
            case "sin", "cos", "sqrt", "sign":
                if let currentNumberString = txtFieldCurrent.text {
                    if let currentNumber = Double(currentNumberString) {
                        unaryExpressionHandle.append(operand: currentNumber, operationId: identifier)
                        if let result = unaryExpressionHandle.eval() {
//                            txtFieldCurrent.text = String(result)
                            txtFieldCurrent.text = formatter.string(from: NSNumber(value: result))
                        }
                    }
                }
            case "+", "-", "*", "/":
                sequenceOpTaps += 1
                if (sequenceOpTaps > 1) {
                    break;
                }
                if let currentNumberString = txtFieldCurrent.text {
                    if let currentNumber = Double(currentNumberString) {
                        if unaryExpressionHandle.hasValue() {
                            expressionHandle.appendUnary(unaryExpr: unaryExpressionHandle.expr() as! UnaryExpression, operationId: identifier)
                            unaryExpressionHandle.clear()
                        }
                        else {
                            expressionHandle.append(operand: currentNumber, operationId: identifier)   
                        }
                        if let result = expressionHandle.eval() {
//                            txtFieldCurrent.text = String(result)
                            txtFieldCurrent.text = formatter.string(from: NSNumber(value: result))
//                            txtFieldCurrent
                            txtFiledResult.text = expressionHandle.toString()! + " ="
                        }
                        shouldClear = true
                    }
                }
            case "=":
                sequenceRetTaps += 1
                if (sequenceRetTaps > 1) {
                    break;
                }
                if let currentNumberString = txtFieldCurrent.text {
                    if let currentNumber = Double(currentNumberString) {
                        if unaryExpressionHandle.hasValue() {
                            expressionHandle.appendUnary(unaryExpr: unaryExpressionHandle.expr() as! UnaryExpression, operationId: nil)
                            unaryExpressionHandle.clear()
                        }
                        else {
                            expressionHandle.append(operand: currentNumber, operationId: nil)
                        }
                        if let result = expressionHandle.eval() {
//                            txtFieldCurrent.text = String(result)
                            txtFieldCurrent.text = formatter.string(from: NSNumber(value: result))
                            txtFiledResult.text = expressionHandle.toString()! + " ="
                        }
                        shouldClear = true
                    }
                }
            case "pi":
                txtFieldCurrent.text = String(M_PI)
                shouldClear  = false
                unaryExpressionHandle.clear()
            case ".":
                shouldInsertDot = true
            case "clear":
                txtFieldCurrent.text = ""
                unaryExpressionHandle.clear()
            case "removeLast":
                if let numberString = txtFieldCurrent.text {
                    let endIndex = numberString.index(before: numberString.endIndex)
                    txtFieldCurrent.text = numberString.substring(to: endIndex)
                    unaryExpressionHandle.clear()
                }
            default:
                print("Nothing to do")
            }
        }
    }
}

