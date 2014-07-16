/// An AST node that represents the logical NOT operator.
class LogicalNot: AbstractExpression, ExpressionProtocol {

    init(_ child: ExpressionProtocol) {
        _child = child
    }

    func child() -> ExpressionProtocol {
        return _child
    }

    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitLogicalNot(self) as T.VisitorResultType
    }

    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visitLogicalNot(self)
    }
    
    let _child: ExpressionProtocol
}
