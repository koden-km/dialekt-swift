//
//  ExpressionProtocol.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 25/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

protocol ExpressionProtocol: NodeProtocol {
    // Fetch the original source code of this expression.
    func source() -> String
    
    // Fetch the index of the first character of this expression in the source code.
    func sourceOffset() -> Int
    
    // Indiciates whether or not the expression contains information about the
    // original source of the expression.
    func hasSource() -> Bool
}
