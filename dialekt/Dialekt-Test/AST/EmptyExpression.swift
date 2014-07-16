/// An AST node that represents an empty expression.
class EmptyExpression: AbstractExpression, ExpressionProtocol {

    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitEmptyExpression(self) as T.VisitorResultType
    }

    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visitEmptyExpression(self)
    }
}
