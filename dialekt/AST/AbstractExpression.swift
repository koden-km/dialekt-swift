//
//  AbstractExpression.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 28/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

class AbstractExpression: ExpressionProtocol {
    var _source: String?
    var _sourceOffset: Int?
    
    // Fetch the original source code of this expression.
    func source() -> String {
        return _source!
    }
    
    // Fetch the index of the first character of this expression in the source code.
    func sourceOffset() -> Int {
        return _sourceOffset!
    }
    
    // Indiciates whether or not the expression contains information about the
    // original source of the expression.
    func hasSource() -> Bool {
        return _source != nil
    }
    
    // Set the original source code of this expression.
    func setSource(source: String, sourceOffset: Int) {
        _source = source
        _sourceOffset = sourceOffset
    }

    // Required to conform to NodeProtocol
    func accept(visitor: VisitorProtocol) -> Any {
        assert(false, "This method must be overriden by the subclass.")
    }
}
