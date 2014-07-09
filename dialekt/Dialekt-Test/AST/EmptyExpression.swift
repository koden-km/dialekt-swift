/// An AST node that represents an empty expression.
class EmptyExpression: AbstractExpression, ExpressionProtocol {
    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: VisitorProtocol>(visitor: T) -> Any {
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitEmptyExpression(self)
    }

    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> ExpressionResult {
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitEmptyExpression(self)
    }
}
