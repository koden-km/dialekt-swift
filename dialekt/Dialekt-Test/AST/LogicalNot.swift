/// An AST node that represents the logical NOT operator.
class LogicalNot: AbstractExpression, ExpressionProtocol {
    init(_ child: ExpressionProtocol) {
        _child = child
    }

    /// Fetch the expression being inverted by the NOT operator.
    func child() -> ExpressionProtocol {
        return _child
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitLogicalNot(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visitLogicalNot(self)
    }

    let _child: ExpressionProtocol
}
