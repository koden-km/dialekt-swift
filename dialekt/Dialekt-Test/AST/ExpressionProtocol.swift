/// An AST node that is an expression.
///
/// Not all nodes in the tree represent an entire (sub-)expression.
protocol ExpressionProtocol: NodeProtocol {

    /// Fetch the first token from the source that is part of this expression.
    func firstToken() -> Token?

    /// Fetch the last token from the source that is part of this expression.
    func lastToken() -> Token?

    /// Set the delimiting tokens for this expression.
    func setTokens(firstToken: Token, lastToken: Token)

    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType
}
