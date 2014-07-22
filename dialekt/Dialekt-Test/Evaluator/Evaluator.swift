import Foundation

class Evaluator: EvaluatorProtocol, ExpressionVisitorProtocol, PatternChildVisitorProtocol {
    init(caseSensitive: Bool = false, emptyIsWildcard: Bool = false) {
        _caseSensitive = caseSensitive
        _emptyIsWildcard = emptyIsWildcard
    }

    /// Evaluate an expression against a set of tags.
    func evaluate(expression: ExpressionProtocol, tags: [String]) -> EvaluationResult {
        _tags = tags
        _expressionResults.removeAll(keepCapacity: true)
        
        let result = EvaluationResult(
            expression.accept(self).isMatch(),
            _expressionResults
        )
        
        _tags.removeAll(keepCapacity: true)
        _expressionResults.removeAll(keepCapacity: true)

        return result
    }

    /// Visit a LogicalAnd node.
    func visit(node: LogicalAnd) -> ExpressionResult {
        var matchedTags = [String]()
        var isMatch = true

        for n in node.children() {
            let result = n.accept(self)

            if !result.isMatch() {
                isMatch = false
            }

            matchedTags.extend(result.matchedTags())
        }

        let unmatchedTags = _tags.filter() {
            tag in
            for t in matchedTags {
                if t == tag {
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

    /// Visit a LogicalOr node.
    func visit(node: LogicalOr) -> ExpressionResult {
        var matchedTags = [String]()
        var isMatch = false

        for n in node.children() {
            var result = n.accept(self)

            if result.isMatch() {
                isMatch = true
            }

            matchedTags.extend(result.matchedTags())
        }

        let unmatchedTags = _tags.filter() {
            tag in
            for t in matchedTags {
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
    func visit(node: LogicalNot) -> ExpressionResult {
        let childResult = node.child().accept(self)

        return _createExpressionResult(
            node,
            isMatch: !childResult.isMatch(),
            matchedTags: childResult.unmatchedTags(),
            unmatchedTags: childResult.matchedTags()
        )
    }

    /// Visit a Tag node.
    func visit(node: Tag) -> ExpressionResult {
        if _caseSensitive {
            return _matchTags(node) {
                return node.name() == $0
            }
        } else {
            return _matchTags(node) {
                return node.name().compare($0, options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame
            }
        }
    }

    /// Visit a pattern node.
    func visit(node: Pattern) -> ExpressionResult {
        var pattern = "/^"

        for n in node.children() {
            pattern += n.accept(self)
        }

        pattern += "$/"

        var options = NSStringCompareOptions.RegularExpressionSearch
        if !_caseSensitive {
            options = NSStringCompareOptions.RegularExpressionSearch | NSStringCompareOptions.CaseInsensitiveSearch
        }

        return _matchTags(node) {
            $0.rangeOfString(pattern, options: options) != nil
        }
    }

    /// Visit a PatternLiteral node.
    func visit(node: PatternLiteral) -> String {
        return NSRegularExpression.escapedPatternForString(node.string())
    }
    
    /// Visit a PatternWildcard node.
    func visit(node: PatternWildcard) -> String {
        return ".*"
    }

    /// Visit a EmptyExpression node.
    func visit(node: EmptyExpression) -> ExpressionResult {
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
