//
//  Operation.swift
//  ios-calculator
//
//  Created by Николай on 11.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit

struct Operations {
    static let addition: (Double, Double) -> Double = (+)
    static let subtraction: (Double, Double) -> Double = (-)
    static let mult: (Double, Double) -> (Double) = (*)
    static let div: (Double, Double) -> Double = (/)
    static let inversion: (Double) -> Double = ({ -$0 })
    static let sinus: (Double) -> Double = (sin)
    static let cosinus: (Double) -> Double = (cos)
    static let sqareRoot: (Double) -> Double = (sqrt)
}

enum Precedence {
    case high
    case low
}

class UnaryOperation {
    private var function: (Double) -> Double
    private var funcId: String
    private let unaryOperationFromId = ["sin" : Operations.sinus,
                                        "cos" : Operations.cosinus,
                                        "sqrt" : Operations.sqareRoot,
                                        "sign" : Operations.inversion]
    
    init(withFuncId functionId: String) {
        self.function = unaryOperationFromId[functionId]!
        funcId = functionId
    }
    
    func apply(_ arg: Double) -> Double {
        return function(arg)
    }
    
    func toString() -> String {
        return funcId
    }
}

class BinaryOperation {
    private var function: (Double, Double) -> Double
    private var funcId: String
    private var precedence: Precedence
    private let binOperationFromId = ["+" : (Operations.addition, Precedence.low),
                                      "-" : (Operations.subtraction, Precedence.low),
                                      "*" : (Operations.mult, Precedence.high),
                                      "/" : (Operations.div, Precedence.high)]
    
    init(withFuncId funcId: String) {
        (function, precedence) = binOperationFromId[funcId]!
        self.funcId = funcId
    }
    
    func apply(_ arg1: Double, _ arg2: Double) -> Double {
        return function(arg1, arg2)
    }
    
    func toString() -> String {
        return funcId
    }
    
    func isLowPrecedence() -> Bool {
        return precedence == .low
    }
}
