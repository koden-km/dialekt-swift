//
//  EmptyExpression.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 25/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

class EmptyExpression: AbstractExpression {
    // Pass this node to the appropriate method on the given visitor.
    override func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitEmptyExpression(self)
    }
}
