/// The overall result of the evaluation of an expression.
public class EvaluationResult {
    public init(
        _ isMatch: Bool,
        _ expressionResults: [ExpressionResult]
    ) {
        _isMatch = isMatch
        _expressionResults = [:]

        for result in expressionResults {
            // Only objects can be hashable, the expression() method returns a protocol.
            _expressionResults[result.expression() as AbstractExpression] = result
        }
    }

    /// Indicates whether or not the expression matched the tag set.
    public func isMatch() -> Bool {
        return _isMatch
    }

    /// Fetch the result for an individual expression node from the AST.
    public func resultOf(expression: ExpressionProtocol) -> ExpressionResult! {
        // Only objects can be hashable, expression is a protocol.
        return _expressionResults[expression as AbstractExpression]
    }

    private let _isMatch: Bool
    private let _expressionResults: [AbstractExpression: ExpressionResult]
}
