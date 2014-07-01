// The result for an invidiual expression in the AST.
class ExpressionResult {
    let _expression: ExpressionProtocol
    let _isMatch: Bool
    let _matchedTags: String[]
    let _unmatchedTags: String[]
    
    init(expression: ExpressionProtocol, isMatch: Bool, matchedTags: String[], unmatchedTags: String[]) {
        _expression = expression
        _isMatch = isMatch
        _matchedTags = matchedTags
        _unmatchedTags = unmatchedTags
    }
    
    // Fetch the expression to which this result applies.
    func expression() -> ExpressionProtocol {
        return _expression
    }
    
    // Indicates whether or not the expression matched the tag set.
    func isMatch() -> Bool {
        return _isMatch
    }
    
    // Fetch the set of tags that matched.
    func matchedTags() -> String[] {
        return _matchedTags
    }
    
    // Fetch set of tags that did not match.
    func unmatchedTags() -> String[] {
        return _unmatchedTags
    }
}
