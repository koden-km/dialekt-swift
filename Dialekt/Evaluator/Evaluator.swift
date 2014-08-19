import Foundation

public class Evaluator: EvaluatorProtocol, ExpressionVisitorProtocol, PatternChildVisitorProtocol {
    public init(caseSensitive: Bool = false, emptyIsWildcard: Bool = false) {
        _caseSensitive = caseSensitive
        _emptyIsWildcard = emptyIsWildcard
    }

    /// Evaluate an expression against a set of tags.
    public func evaluate(expression: ExpressionProtocol, tags: [String]) -> EvaluationResult {
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
    public func visit(node: LogicalAnd) -> ExpressionResult {
        var matchedTags = [String]()
        var isMatch = true
        
        var x = [String:String]()

        for n in node.children() {
            let result = n.accept(self)

            if !result.isMatch() {
                isMatch = false
            }

            matchedTags.extend(
                result.matchedTags().filter() {
                    !contains(matchedTags, $0)
                }
            )
        }

        let unmatchedTags = _tags.filter() {
            !contains(matchedTags, $0)
        }

        return createExpressionResult(
            node,
            isMatch: isMatch,
            matchedTags: matchedTags,
            unmatchedTags: unmatchedTags
        )
    }

    /// Visit a LogicalOr node.
    public func visit(node: LogicalOr) -> ExpressionResult {
        var matchedTags = [String]()
        var isMatch = false

        for n in node.children() {
            var result = n.accept(self)

            if result.isMatch() {
                isMatch = true
            }

            matchedTags.extend(
                result.matchedTags().filter() {
                    !contains(matchedTags, $0)
                }
            )
        }

        let unmatchedTags = _tags.filter() {
            !contains(matchedTags, $0)
        }

        return createExpressionResult(
            node,
            isMatch: isMatch,
            matchedTags: matchedTags,
            unmatchedTags: unmatchedTags
        )
    }

    /// Visit a LogicalNot node.
    public func visit(node: LogicalNot) -> ExpressionResult {
        let childResult = node.child().accept(self)

        return createExpressionResult(
            node,
            isMatch: !childResult.isMatch(),
            matchedTags: childResult.unmatchedTags(),
            unmatchedTags: childResult.matchedTags()
        )
    }

    /// Visit a Tag node.
    public func visit(node: Tag) -> ExpressionResult {
        if _caseSensitive {
            return matchTags(node) {
                return node.name() == $0
            }
        } else {
            return matchTags(node) {
                return node.name().compare($0, options: NSStringCompareOptions.CaseInsensitiveSearch) == NSComparisonResult.OrderedSame
            }
        }
    }

    /// Visit a pattern node.
    public func visit(node: Pattern) -> ExpressionResult {
        var pattern = "^"

        for n in node.children() {
            pattern += n.accept(self)
        }

        pattern += "$"

        var options = NSStringCompareOptions.RegularExpressionSearch
        if !_caseSensitive {
            options = NSStringCompareOptions.RegularExpressionSearch | NSStringCompareOptions.CaseInsensitiveSearch
        }

        return matchTags(node) {
            $0.rangeOfString(pattern, options: options) != nil
        }
    }

    /// Visit a PatternLiteral node.
    public func visit(node: PatternLiteral) -> String {
        return NSRegularExpression.escapedPatternForString(node.string())
    }
    
    /// Visit a PatternWildcard node.
    public func visit(node: PatternWildcard) -> String {
        return ".*"
    }

    /// Visit a EmptyExpression node.
    public func visit(node: EmptyExpression) -> ExpressionResult {
        return createExpressionResult(
            node,
            isMatch: _emptyIsWildcard,
            matchedTags: _emptyIsWildcard ? _tags : [String](),
            unmatchedTags: _emptyIsWildcard ? [String]() : _tags
        )
    }

    private func matchTags(expression: ExpressionProtocol, predicate: (tag: String) -> Bool) -> ExpressionResult {
        var matchedTags = [String]()
        var unmatchedTags = [String]()

        for tag in _tags {
            if predicate(tag: tag) {
                matchedTags.append(tag)
            } else {
                unmatchedTags.append(tag)
            }
        }

        return createExpressionResult(
            expression,
            isMatch: matchedTags.count > 0,
            matchedTags: matchedTags,
            unmatchedTags: unmatchedTags
        )
    }

    private func createExpressionResult(expression: ExpressionProtocol, isMatch: Bool, matchedTags: [String], unmatchedTags: [String]) -> ExpressionResult {
        let result = ExpressionResult(
            expression,
            isMatch,
            matchedTags,
            unmatchedTags
        )

        _expressionResults.append(result)

        return result
    }

    private let _caseSensitive: Bool
    private let _emptyIsWildcard: Bool
    private var _tags = [String]()
    private var _expressionResults = [ExpressionResult]()
}
