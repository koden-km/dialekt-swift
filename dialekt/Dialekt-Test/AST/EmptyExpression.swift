/// An AST node that represents an empty expression.
class EmptyExpression: AbstractExpression, ExpressionProtocol {
    /// Pass this node to the appropriate method on the given visitor.
    func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitEmptyExpression(self)
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept(visitor: ExpressionVisitorProtocol) -> ExpressionResult {
        return visitor.visitEmptyExpression(self)
    }
}
