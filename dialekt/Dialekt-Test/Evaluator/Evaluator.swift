/*
class Evaluator: EvaluatorProtocol, ExpressionVisitorProtocol, PatternChildVisitorProtocol {
    init(caseSensitive: Bool = false, emptyIsWildcard: Bool = false) {
        _caseSensitive = caseSensitive
        _emptyIsWildcard = emptyIsWildcard
    }

    /// Evaluate an expression against a set of tags.
    func evaluate(expression: ExpressionProtocol, tags: [String]) -> EvaluationResult {
        _tags = tags
        _expressionResults.removeAll(keepCapacity: true)
        
        let result = EvaluationResult(expression.accept(self).isMatch(), _expressionResults)
        
        _tags.removeAll(keepCapacity: true)
        _expressionResults.removeAll(keepCapacity: true)
        
        return result
    }
    
    /// Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> ExpressionResult {
        var matchedTags = [String]()
        var isMatch = true
        
        for n in node.children() {
             var result = n.accept(self)

// TODO: something like this?
//            if var result = n.accept(self) as xxxxProtocol {
//            }
            
            if !result.isMatch() {
                isMatch = false
            }
            
            for tag in result.matchedTags() {
                matchedTags.append(tag)
            }
        }

//        let unmatchedTags = [String]()
        let unmatchedTags = _tags.filter() {
            tag in
            for t in self._tags {
                if t == tag {
                    return false
                }
                
            }
            return true
        }
        
//            let expressionresult = ExpressionResult(node, isMatch, matchedTags, unmatchedTags)
//            _expressionResults.append(expressionResult)

        
        return _createExpressionResult(
            node,
            isMatch: isMatch,
            matchedTags: matchedTags,
            unmatchedTags: unmatchedTags
        )
    }

    /// Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> ExpressionResult {
        var matchedTags = [String]()
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
            
//        let unmatchedTags = [String]()
        let unmatchedTags = _tags.filter() {
            tag in
            for t in self._tags {
                if tag == t {
                    return false
                }
                
            }
            return true
        }
        
        return _createExpressionResult(
            node,
            isMatch: isMatch,
            matchedTags: matchedTags,
            unmatchedTags: unmatchedTags
        )
    }

    /// Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> ExpressionResult {
        let childResult = node.child().accept(self)
        
        return _createExpressionResult(
            node,
            isMatch: !childResult.isMatch(),
            matchedTags: childResult.unmatchedTags(),
            unmatchedTags: childResult.matchedTags()
        )
    }
    
    /// Visit a Tag node.
    func visitTag(node: Tag) -> ExpressionResult {
//        var predicate: (tag: String) -> Bool
        if _caseSensitive {
//            predicate = func (tag) ...
            return _matchTags(node) { return $0 == "TODO" }
        } else {
//            predicate = func (tag) ...
            return _matchTags(node) { return $0 == "TODO" }
        }
        
//        return _matchTags(node, predicate)
    }
    
    /// Visit a pattern node.
    func visitPattern(node: Pattern) -> ExpressionResult {
        var pattern = "/^"
        
        for n in node.children() {
//        for n in enumerate(node.children()) {
            // TESTING: this should work, but i'm messing with the generics
            pattern += n.accept(self)
        }
        
        pattern += "$/"
        
        if !_caseSensitive {
            pattern += "i"
        }

// i have no idea...
//        let func predicate(tag: String) -> Bool {
//            //                return preg_match(pattern, tag)
//            return false   // TODO
//        }
// TODO: just stub this for now. make this thing accept an actual predicate
//        return _matchTags(node) { return false }
//        return _matchTags(node, predicate: (tag: String) -> Bool in return tag == "TODO")
//        return _matchTags(node, predicate: (tag: String) -> Bool in return tag == "TODO")
//        return _matchTags(node) { tag: String in return tag == "TODO")
        return _matchTags(node) { return $0 == "TODO" }
        
//            function ($tag) use ($pattern) {
//                return preg_match($pattern, $tag);
//            }


// i have no idea...
//            (tag: String) -> Bool in {
////                return preg_match(pattern, tag)
//                return false   // TODO
//            }
    }

    /// Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> String {
        //return preg_quote(node.string(), "/")
        return "TODO"
    }
// TESTING: make the return type the same as the expression return types to see if it satisifies the generic protocol
//func visitPatternLiteral(node: PatternLiteral) -> ExpressionResult {
//return ExpressionResult(expression: EmptyExpression(), isMatch: false, matchedTags: [], unmatchedTags: [])
//}
    
    /// Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> String {
        return ".*"
    }
// TESTING: make the return type the same as the expression return types to see if it satisifies the generic protocol
//func visitPatternWildcard(node: PatternWildcard) -> ExpressionResult {
//return ExpressionResult(expression: EmptyExpression(), isMatch: false, matchedTags: [], unmatchedTags: [])
//}

    /// Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> ExpressionResult {
        return _createExpressionResult(
            node,
            isMatch: _emptyIsWildcard,
            matchedTags: _emptyIsWildcard ? _tags : [String](),
            unmatchedTags: _emptyIsWildcard ? [String]() : _tags
        )
    }
    
    func _matchTags(expression: ExpressionProtocol, predicate: (tag: String) -> Bool) -> ExpressionResult {
        var matchedTags = [String]()
        var unmatchedTags = [String]()
        
        for tag in _tags {
            if predicate(tag: tag) {
                matchedTags.append(tag)
            } else {
                unmatchedTags.append(tag)
            }
        }
        
        return _createExpressionResult(
            expression,
            isMatch: matchedTags.count > 0,
            matchedTags: matchedTags,
            unmatchedTags: unmatchedTags
        )
    }
    
    func _createExpressionResult(expression: ExpressionProtocol, isMatch: Bool, matchedTags: [String], unmatchedTags: [String]) -> ExpressionResult {
        let result = ExpressionResult(
            expression,
            isMatch,
            matchedTags,
            unmatchedTags
        )
        
        _expressionResults.append(result)
        
        return result
    }

    let _caseSensitive: Bool
    let _emptyIsWildcard: Bool
    var _tags = [String]()
    var _expressionResults = [ExpressionResult]()
}
*/