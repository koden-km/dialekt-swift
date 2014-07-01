//
//  Evaluator.swift
//  Dialekt-Test
//
//  Created by Kevin Millar on 30/06/2014.
//  Copyright (c) 2014 Kevin Millar. All rights reserved.
//

import Foundation

class Evaluator: EvaluatorProtocol, VisitorProtocol {
    let _caseSensitive: Bool
    let _emptyIsWildcard: Bool
    var _tags = String[]()
    var _expressionResults = ExpressionResult[]()
    
    init(caseSensitive:Bool = false, emptyIsWildcard: Bool = false) {
        _caseSensitive = caseSensitive
        _emptyIsWildcard = emptyIsWildcard
    }
    
    // Evaluate an expression against a set of tags.
    func evaluate(expression: ExpressionProtocol, tags: String[]) -> EvaluationResult {
        _tags = tags.copy()
        _expressionResults.removeAll(keepCapacity: true)
        
        let result = EvaluationResult(expression.accept(self).isMatch(), _expressionResults)
        
        _tags.removeAll(keepCapacity: true)
        _expressionResults.removeAll(keepCapacity: true)
        
        return result
    }
    
    // Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> Any {
        var matchedTags = String[]()
        var isMatch = true
        
        for n in node.children() {
            var result = n.accept(self)
            
            if !result.isMatch() {
                isMatch = false
            }
            
            for tag in result.matchedTags() {
                matchedTags.append(tag)
            }
        }

//        let unmatchedTags = String[]()
        let unmatchedTags = _tags.filter() {
            for tag in _tags {
                if tag == includeElement {
                    return false
                }
                
            }
            return true
        }
        
//            let expressionresult = ExpressionResult(node, isMatch, matchedTags, unmatchedTags)
//            _expressionResults.append(expressionResult)

        let expressionResult = ExpressionResult(
            expression: node,
            isMatch: isMatch,
            matchedTags: matchedTags,
            unmatchedTags: unmatchedTags
        )
        _expressionResults.append(expressionResult)

        return _expressionResults
    }

    // Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> Any {
        var matchedTags = String[]()
        var isMatch = false
        
        for n in node.children() {
            var result = n.accept(self)
            
            if result.isMatch() {
                isMatch = true
            }
            
            for tag in result.matchedTags() {
                matchedTags.append(tag)
            }
        }
            
//        let unmatchedTags = String[]()
        let unmatchedTags = _tags.filter() {
            for tag in _tags {
                if tag == includeElement {
                    return false
                }
                
            }
            return true
        }
        
        let expressionResult = ExpressionResult(
            expression: node,
            isMatch: isMatch,
            matchedTags: matchedTags,
            unmatchedTags: unmatchedTags
        )
        _expressionResults.append(expressionResult)
        
        return _expressionResults
    }

    // Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> Any {
        let childResult = node.child().accept(self)
        
        let expressionResult = ExpressionResult(
            expression: node,
            isMatch: !childResult.isMatch(),
            matchedTags: childResult.unmatchedTags(),
            unmatchedTags: childResult.matchedTags()
        )
        _expressionResults.append(expressionResult)
        
        return _expressionResults
    }
    
    // Visit a Tag node.
    func visitTag(node: Tag) -> Any {
        var predicate: (tag: String) -> Bool
        if _caseSensitive {
//            predicate = func (tag) ...
        } else {
//            predicate = func (tag) ...
        }
        
        return _matchTags(node, predicate)
    }
    
    // Visit a pattern node.
    func visitPattern(node: Pattern) -> Any {
        var pattern = "/^"
        
        for n in node.children() {
            pattern += n.accept(self)
        }
        
        pattern += "$/"
        
        if !_caseSensitive {
            pattern += "i"
        }
        
        return _matchTags(node) {
            
//            function ($tag) use ($pattern) {
//                return preg_match($pattern, $tag);
//            }


// i have no idea...
            (tag: String) -> Bool {
                return preg_match(pattern, tag)
            }
        }
    }

    // Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> Any {
        return preg_quote(node.string(), "/")
    }
    
    // Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> Any {
        return ".*"
    }

    // Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> Any {
        let expressionResult = ExpressionResult(
            expression: node,
            isMatch: _emptyIsWildcard,
            matchedTags: _emptyIsWildcard ? _tags : String[](),
            unmatchedTags: _emptyIsWildcard ? String[]() : _tags
        )
        _expressionResults.append(expressionResult)
        
        return _expressionResults
    }
    
    func _matchTags(expression: ExpressionProtocol, predicate: (tag: String) -> Bool) -> ExpressionResult[] {
        var matchedTags: String[]
        var unmatchedTags: String[]
        
        for tag in _tags {
            if predicate(tag: tag) {
                matchedTags.append(tag)
            } else {
                unmatchedTags.append(tag)
            }
        }
        
        let expressionResult = ExpressionResult(
            expression: expression,
            isMatch: matchedTags.count > 0,
            matchedTags: matchedTags,
            unmatchedTags: unmatchedTags
        )
        _expressionResults.append(expressionResult)
        
        return _expressionResults
    }
}
