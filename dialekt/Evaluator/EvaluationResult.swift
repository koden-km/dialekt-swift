//
//  EvaluationResult.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 30/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

// The overall result of the evaluation of an expression.
class EvaluationResult {
    let _isMatch: Bool
    let _expressionResults: Dictionary<String,ExpressionResult>
    
    init(isMatch: Bool, expressionResults: ExpressionResult[]) {
        _isMatch = isMatch
        
        for result in expressionResults {
            let key = result.expression().source() + ":" + result.expression().sourceOffset().description
            _expressionResults[key] = result
        }
    }
    
    // Indicates whether or not the expression matched the tag set.
    func isMatch() -> Bool {
        return _isMatch
    }
    
    // Fetch the result for an individual expression node from the AST.
    func resultOf(expression: ExpressionProtocol) -> ExpressionResult {
        let key = expression.source() + ":" + expression.sourceOffset().description
        return _expressionResults[key]!
    }
}