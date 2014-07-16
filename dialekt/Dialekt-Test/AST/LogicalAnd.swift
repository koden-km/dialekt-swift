/// An AST node that represents the logical AND operator.
class LogicalAnd: AbstractPolyadicExpression, ExpressionProtocol {

    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitLogicalAnd(self) as T.VisitorResultType
    }

    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visitLogicalAnd(self)
    }
}
