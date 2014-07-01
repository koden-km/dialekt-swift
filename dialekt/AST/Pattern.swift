//
//  Pattern.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 1/07/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

class Pattern: AbstractExpression, ExpressionProtocol {
    var _children = PatternChildProtocol[]()
    
    init(args: PatternChildProtocol[]) {
        for expression in args {
            self.add(expression)
        }
    }
    
    convenience init(args: PatternChildProtocol...) {
        self.init(args: args)
    }
    
    // Add a child expression to this operator.
    func add(expression: PatternChildProtocol) {
        _children.append(expression)
    }
    
    // Fetch an array of this operator's children.
    func children() -> PatternChildProtocol[] {
        return _children
    }
    
    // Required to conform to NodeProtocol
    override func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitPattern(self)
    }
}
