//
//  PatternLiteral.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 30/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

class PatternLiteral: PatternChildProtocol {
    let _string: String
    
    init(string: String) {
        _string = string
    }
    
    // Fetch the string to be matched.
    func string() -> String {
        return _string
    }
    
    // Pass this node to the appropriate method on the given visitor.
    func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitPatternLiteral(self)
    }
}
