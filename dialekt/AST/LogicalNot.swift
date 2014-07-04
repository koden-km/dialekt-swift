// An AST node that represents the logical NOT operator.
class LogicalNot: AbstractExpression, ExpressionProtocol {
    let _child: ExpressionProtocol

    init(child: ExpressionProtocol) {
        _child = child
    }
    
    // Fetch the expression being inverted by the NOT operator.
    func child() -> ExpressionProtocol {
        return _child
    }
    
    // Pass this node to the appropriate method on the given visitor.
    func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitLogicalNot(self)
    }

    // Pass this node to the appropriate method on the given visitor.
    func accept(visitor: ExpressionVisitorProtocol) -> ExpressionResult {
        return visitor.visitLogicalNot(self)
    }
}
