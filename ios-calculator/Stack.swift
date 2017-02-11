//
//  Stack.swift
//  ios-calculator
//
//  Created by Николай on 11.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit

internal class Stack<ValueType> : NSObject {
    private var topIndex : Int
    private var valuesArray : [ValueType?]
    
    override init() {
        topIndex = -1
        valuesArray = [ValueType?]()
    }
    
    func push(_ value: ValueType) {
        topIndex += 1;
        if topIndex == valuesArray.count {
            valuesArray.append(value)
        }
        else {
            valuesArray[topIndex] = value
        }
    }
    
    func pop() -> ValueType? {
        if topIndex < 0 {
            return nil
        }
        let topValue = valuesArray[topIndex]
        topIndex -= 1
        return topValue
    }
    
    func top() -> ValueType? {
        if topIndex < 0 {
            return nil
        }
        return valuesArray[topIndex]
    }
    
    func count() -> Int {
        return topIndex + 1
    }
}
