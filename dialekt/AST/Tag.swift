//
//  Tag.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 25/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

class Tag: AbstractExpression, ExpressionProtocol {
    let _name: String

    init(name: String) {
        _name = name
    }
    
    // Fetch the tag name.
    func name() -> String {
        return _name
    }
    
    // Pass this node to the appropriate method on the given visitor.
    override func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitTag(self)
    }
}
