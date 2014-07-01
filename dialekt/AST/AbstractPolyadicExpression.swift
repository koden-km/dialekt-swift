//
//  AbstractPolyadicOperator.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 25/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

class AbstractPolyadicExpression: AbstractExpression {
    var _children = ExpressionProtocol[]()

    init(args: ExpressionProtocol[]) {
        for expression in args {
            self.add(expression)
        }
    }

    convenience init(args: ExpressionProtocol...) {
        self.init(args: args)
    }
    
    // Add a child expression to this operator.
    func add(expression: ExpressionProtocol) {
        _children.append(expression)
    }
    
    // Fetch an array of this operator's children.
    func children() -> ExpressionProtocol[] {
        return _children
    }
    
    // Required to conform to NodeProtocol
    override func accept(visitor: VisitorProtocol) -> Any {
        assert(false, "This method must be overriden by the subclass.")
    }
}