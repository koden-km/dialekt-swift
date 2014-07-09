/// Interface for expression evaluators.
///
/// An expression evaluator checks whether a set of tags match against a certain expression.
protocol EvaluatorProtocol {
    /// Evaluate an expression against a set of tags.
    func evaluate<T: ExpressionProtocol>(expression: T, tags: [String]) -> EvaluationResult
}
