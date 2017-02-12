//
//  Resolver.swift
//  ios-calculator
//
//  Created by Николай on 11.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit

class ExpressionHandle : NSObject, NSCoding {
    private var currentExpression: Expression!
    private var operationId: String!
    var operationsHistory: [String]!
    
    override init() {
        currentExpression = nil
        operationId = nil
        operationsHistory = []
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        if let decodedHistory = aDecoder.decodeObject(forKey: "operationHistory") as? [String] {
            operationsHistory = decodedHistory
        }
        
        NSLog("Expression handle init with decoder")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(operationsHistory, forKey: "operationHistory")
        NSLog("Expression handle encode")
    }
    
    func append(operand: Double, operationId: String!)
    {
        let numberExpression = NumberExpression(withValue: operand)
        if self.operationId == nil || currentExpression == nil {
            currentExpression = numberExpression
        }
        else {
            currentExpression = BinaryExpression(withLeftExpr: currentExpression,
                                                 andRightExpr: numberExpression,
                                                 andOperation: BinaryOperation(withFuncId: self.operationId))
        }
        
        if currentExpression != nil && operationId == nil {
            operationsHistory.append(currentExpression.toString() + " = " + String(currentExpression.eval()))
        }
        
        self.operationId = operationId
    }
    
    func appendUnary(unaryExpr: UnaryExpression, operationId: String!) {
        if currentExpression == nil || self.operationId == nil {
            currentExpression = unaryExpr
        }
        else {
            currentExpression = BinaryExpression(withLeftExpr: currentExpression,
                                                 andRightExpr: unaryExpr,
                                                 andOperation: BinaryOperation(withFuncId: self.operationId))
        }
        
        self.operationId = operationId
    }
    
    func eval() -> Double? {
        if currentExpression == nil {
            return nil
        }
        
        return currentExpression.eval()
    }
    
    func toString() -> String? {
        if currentExpression == nil {
            return nil
        }
        
        return currentExpression.toString()
    }
}

class UnaryExpressionHandle {
    
    private var currentUnaryExpr: Expression!
    
    func append(operand: Double,
                operationId: String!)
    {
        if currentUnaryExpr == nil {
            currentUnaryExpr = NumberExpression(withValue: operand)
        }
        
        currentUnaryExpr = UnaryExpression(withExpr: currentUnaryExpr,
                                           andOperation: UnaryOperation(withFuncId: operationId))
    }
    
    func eval() -> Double? {
        if (currentUnaryExpr == nil) {
            return nil
        }
        
        return currentUnaryExpr.eval()
    }
    
    func hasValue() -> Bool {
        return currentUnaryExpr != nil
    }
    
    func clear() {
        currentUnaryExpr = nil
    }
    
    func expr() -> Expression! {
        return currentUnaryExpr
    }
}
