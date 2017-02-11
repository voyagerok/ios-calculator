//
//  Resolver.swift
//  ios-calculator
//
//  Created by Николай on 11.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit

class ExpressionHandle {
    private var currentExpression: Expression!
    private var operationId: String!
    
    init() {
        currentExpression = nil
        operationId = nil
    }
    
    func append(operand: Double,
                      operationId: String!)
    {
        let numberExpression = NumberExpression(withValue: operand)
        if currentExpression == nil || self.operationId == nil {
            currentExpression = numberExpression
        }
        else {
            currentExpression = BinaryExpression(withLeftExpr: currentExpression,
                                                 andRightExpr: numberExpression,
                                                 andOperation: BinaryOperation(withFuncId: self.operationId))
        }
        
        self.operationId = operationId
    }
    
    func appendUnary(unaryExpr: UnaryExpression,
                     operationId: String!) {
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
