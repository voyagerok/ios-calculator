//
//  Expression.swift
//  ios-calculator
//
//  Created by Николай on 11.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit

protocol Expression {
    func eval() -> Double;
    func toString() -> String;
}


class NumberExpression: Expression {
    var value: Double
    let formatter: NumberFormatter
    
    init(withValue value: Double) {
        self.value = value
        formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
    }
    
    func eval() -> Double {
        return value
    }
    
    func toString() -> String {
        return formatter.string(from: NSNumber(value: value))!
    }
}

class UnaryExpression: Expression {
    var expr: Expression
//    var function: (Double) -> Double
    var operation: UnaryOperation
    
//    init(withExpr expr: Expression,
//         andFunc function: @escaping (Double) -> Double)
//    {
//        self.expr = expr
//        self.function = function
//    }

    init(withExpr expr: Expression,
         andOperation operation: UnaryOperation)
    {
        self.expr = expr
        self.operation = operation
    }
    
    func eval() -> Double {
//        return function(expr.eval())
        return operation.apply(expr.eval())
    }
    
    func toString() -> String {
        return "\(operation.toString())(\(expr.toString()))"
    }
}

class BinaryExpression: Expression {
    var leftExpr: Expression
    var rightExpr: Expression
//    var function: (Double, Double) -> Double
    var operation: BinaryOperation
    
    init(withLeftExpr leftExpr: Expression,
         andRightExpr rightExpr: Expression,
//         andFunction function: @escaping (Double, Double) -> Double)
        andOperation operation: BinaryOperation)
    {
        self.leftExpr = leftExpr
        self.rightExpr = rightExpr
//        self.function = function
        self.operation = operation
    }
    
    func eval() -> Double {
//        return function(leftExpr.eval(), rightExpr.eval())
        return operation.apply(leftExpr.eval(), rightExpr.eval())
    }
    
    func toString() -> String {
        let str = "\(leftExpr.toString()) \(operation.toString()) \(rightExpr.toString())"
        if operation.isLowPrecedence() {
            return "(" + str + ")"
        }
        return str
    }
}
