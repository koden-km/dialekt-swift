//
//  EvaluatorProtocol.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 30/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

// Interface for expression evaluators.
// An expression evaluator checks whether a set of tags match against a certain expression.
protocol Evaluator {
    // Evaluate an expression against a set of tags.
    func evaluate(expression: ExpressionProtocol, tags: String[]) -> EvaluationResult
}
