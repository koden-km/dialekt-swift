/// An AST node that represents the logical AND operator.
class LogicalAnd: AbstractPolyadicExpression, ExpressionProtocol {
    init(args: ExpressionProtocol...) {
        super.init(args: args)
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitLogicalAnd(self)
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept(visitor: ExpressionVisitorProtocol) -> ExpressionResult {
        return visitor.visitLogicalAnd(self)
    }
}
