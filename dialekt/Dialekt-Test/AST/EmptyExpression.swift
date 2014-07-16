/// An AST node that represents an empty expression.
class EmptyExpression: AbstractExpression, ExpressionProtocol {
    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitEmptyExpression(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visitEmptyExpression(self)
    }
}
