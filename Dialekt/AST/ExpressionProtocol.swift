/// An AST node that is an expression.
///
/// Not all nodes in the tree represent an entire (sub-)expression.
public protocol ExpressionProtocol: NodeProtocol {
    /// Fetch the first token from the source that is part of this expression.
    func firstToken() -> Token?

    /// Fetch the last token from the source that is part of this expression.
    func lastToken() -> Token?

    /// Set the delimiting tokens for this expression.
    func setTokens(firstToken: Token, _ lastToken: Token)

    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType
}
