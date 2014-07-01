//
//  LogicalNot.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 28/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

class LogicalNot: AbstractExpression, ExpressionProtocol {
    let _child: ExpressionProtocol
    
    init(child: ExpressionProtocol) {
        _child = child
    }
    
    // Fetch the expression being inverted by the NOT operator.
    func child() -> ExpressionProtocol {
        return _child
    }
    
    // Pass this node to the appropriate method on the given visitor.
    override func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitLogicalNot(self)
    }
}
