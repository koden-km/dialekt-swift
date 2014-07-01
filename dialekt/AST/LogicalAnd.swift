//
//  LogicalAnd.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 28/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

class LogicalAnd: AbstractPolyadicExpression {
    init(args: ExpressionProtocol...) {
        super.init(args: args)
    }

    // Pass this node to the appropriate method on the given visitor.
    override func accept(visitor: VisitorProtocol) -> Any {
        visitor.visitLogicalAnd(self)
    }
}
