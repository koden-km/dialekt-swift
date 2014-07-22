/// The overall result of the evaluation of an expression.
public class EvaluationResult {
    public init(
        _ isMatch: Bool,
        _ expressionResults: [ExpressionResult]
    ) {
        _isMatch = isMatch
        _expressionResults = [:]

        for result in expressionResults {
            let key = _makeKey(result.expression())
            _expressionResults[key] = result
        }
    }

    /// Indicates whether or not the expression matched the tag set.
    public func isMatch() -> Bool {
        return _isMatch
    }

    /// Fetch the result for an individual expression node from the AST.
    public func resultOf(expression: ExpressionProtocol) -> ExpressionResult {
        let key = _makeKey(expression)
        return _expressionResults[key]!
    }

    private func makeKey(expression: ExpressionProtocol) -> String {
        return _stringifyToken(expression.firstToken()) +
            ":" + _stringifyToken(expression.lastToken())
    }

    private func stringifyToken(token: Token?) -> String {
        if let t = token {
            let sep = ","
            var key = t.tokenType.description + sep
            key += t.value + sep
            key += t.startOffset.description + sep
            key += t.endOffset.description + sep
            key += t.lineNumber.description + sep
            key += t.columnNumber.description
            return key
        }

        return ""
    }

    private let _isMatch: Bool
    private let _expressionResults: [String: ExpressionResult]
}
