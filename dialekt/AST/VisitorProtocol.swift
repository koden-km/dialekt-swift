//
//  VisitorProtocol.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 25/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

// Protocol for node visitors.
// Pass the node to the appropriate method on the given visitor.
protocol VisitorProtocol {
    func visitLogicalAnd(node: LogicalAnd) -> Any
    func visitLogicalOr(node: LogicalOr) -> Any
    func visitLogicalNot(node: LogicalNot) -> Any
    func visitTag(node: Tag) -> Any
    func visitPattern(node: Pattern) -> Any
    func visitPatternLiteral(node: PatternLiteral) -> Any
    func visitPatternWildcard(node: PatternWildcard) -> Any
    func visitEmptyExpression(node: EmptyExpression) -> Any
}
