///// An AST node that represents the logical OR operator.
class LogicalOr: AbstractPolyadicExpression, ExpressionProtocol {

    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitLogicalOr(self) as T.VisitorResultType
    }

    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visitLogicalOr(self)
    }
}
