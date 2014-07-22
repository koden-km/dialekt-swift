/// The result for an invidiual expression in the AST.
public class ExpressionResult {
    public init(
        _ expression: ExpressionProtocol,
        _ isMatch: Bool,
        _ matchedTags: [String],
        _ unmatchedTags: [String]
    ) {
        _expression = expression
        _isMatch = isMatch
        _matchedTags = matchedTags
        _unmatchedTags = unmatchedTags
    }

    /// Fetch the expression to which this result applies.
    public func expression() -> ExpressionProtocol {
        return _expression
    }

    /// Indicates whether or not the expression matched the tag set.
    public func isMatch() -> Bool {
        return _isMatch
    }

    /// Fetch the set of tags that matched.
    public func matchedTags() -> [String] {
        return _matchedTags
    }

    /// Fetch set of tags that did not match.
    public func unmatchedTags() -> [String] {
        return _unmatchedTags
    }

    private let _expression: ExpressionProtocol
    private let _isMatch: Bool
    private let _matchedTags: [String]
    private let _unmatchedTags: [String]
}
