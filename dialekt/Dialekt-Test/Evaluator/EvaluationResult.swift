/// The overall result of the evaluation of an expression.
class EvaluationResult {
    init(
        _ isMatch: Bool,
        _ expressionResults: [ExpressionResult]
    ) {
        _isMatch = isMatch
        _expressionResults = [:]

        for result in expressionResults {
            // TODO: might need to make ExpressionProtocol support "Hashable" for use as dictionary key?
            //let key = result.expression().source() + ":" + result.expression().sourceOffset().description
//            let key = result.expression().firstToken()?.value + "::" + result.expression().lastToken()?.value
//            result.expression().firstToken()?.value
            let key = "TODO"
            _expressionResults[key] = result
        }
    }

    /// Indicates whether or not the expression matched the tag set.
    func isMatch() -> Bool {
        return _isMatch
    }

    /// Fetch the result for an individual expression node from the AST.
    func resultOf(expression: ExpressionProtocol) -> ExpressionResult {
        //let key = expression.source() + ":" + expression.sourceOffset().description
        let key = "TODO"
        return _expressionResults[key]!
    }

    let _isMatch: Bool
    let _expressionResults: [String:ExpressionResult]
}
