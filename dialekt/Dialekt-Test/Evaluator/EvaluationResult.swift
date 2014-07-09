/// The overall result of the evaluation of an expression.
class EvaluationResult {
    let _isMatch: Bool
    let _expressionResults = [String:ExpressionResult]()
    
    init(isMatch: Bool, expressionResults: [ExpressionResult]) {
        _isMatch = isMatch
        
        // TODO: might need to make ExpressionProtocol support hashable for use as dictionary key?
        
        for result in expressionResults {
            //let key = result.expression().source() + ":" + result.expression().sourceOffset().description
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
}
